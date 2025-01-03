{ config, lib, ... }:
let
  #OWNER_EMAIL = "postmaster@example.org";  # Change this!
  #MAILMAN_HOST = "mailman.example.org";    # Change this!
  cfg = config.mailinglist;
in
{
  options = {
    mailinglist = {
      enable = lib.mkEnableOption (lib.mdDoc "");
      tls = lib.mkEnableOption (lib.mdDoc "");
      ownerEmail = lib.mkOption {
        type = lib.types.uniq lib.types.str;
        description = lib.mdDoc ''
          Email of the platform owner
        '';
      hostname = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = lib.mdDoc ''
          Platform hostname. This option enables an Nginx virtualhost as well.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.postfix = {
      enable = true;
      relayDomains = ["hash:/var/lib/mailman/data/postfix_domains"];
      sslCert = config.security.acme.certs.${cfg.ownerEmail}.directory + "/full.pem";
      sslKey = config.security.acme.certs.${cfg.ownerEmail}.directory + "/key.pem";
      config = {
        transport_maps = ["hash:/var/lib/mailman/data/postfix_lmtp"];
        local_recipient_maps = ["hash:/var/lib/mailman/data/postfix_lmtp"];
      };
    };

    services.mailman = {
      enable = true;
      siteOwner = cfg.ownerEmail;
      webUser = config.services.uwsgi.user;
      hyperkitty.enable = true;
      hyperkitty.baseUrl = "http://localhost:33141/hyperkitty/";
      webHosts = [cfg.hostname];
    };

    systemd.services.uwsgi.restartTriggers = [
      config.environment.etc."mailman3/settings.py".source
    ];

    systemd.services.mailman-settings.script = ''
      chmod o+x /var/lib/mailman-web
    '';

    services.uwsgi = {
      enable = true;
      plugins = ["python3"];
      instance = {
        type = "normal";
        pythonPackages = (
          # TODO: I hope there is a nicer way of doing this:
          self: with self.override {
            overrides = self: super: { django = self.django_1_11; };
          }; [ mailman-web ]
        );
        # uwsgi protocol socket for nginx
        socket = "127.0.0.1:33140";
        # http socket for mailman core to reach the hyperkitty API directly
        http-socket = "127.0.0.1:33141";
        wsgi-file = "${config.services.mailman.webRoot}/mailman_web/wsgi.py";
        chdir = "/var/lib/mailman-web";
        master = true;
        processes = 4;
        vacuum = true;
      };
    };

    security.acme = lib.mkIf cfg.tls {
      email = cfg.ownerEmail;
      acceptTerms = true;
    };

    services.nginx = {
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = cfg.tls;
      virtualHosts.${cfg.hostname} = {
        enableACME = cfg.tls;
        forceSSL = cfg.tls;
        locations."/static/".alias = "/var/lib/mailman-web/static/";
        locations."/".extraConfig = ''
          uwsgi_pass 127.0.0.1:33140;
          include ${config.services.nginx.package}/conf/uwsgi_params;
        '';
      };
    };

  };

}
