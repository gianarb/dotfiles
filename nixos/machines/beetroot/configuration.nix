# Edit this configuration file to define what should be installed on 
# your system.  Help is available in the configuration.nix(5) man page 
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/gianarb
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  users.users.root.openssh.authorizedKeys.keys = config.users.users.gianarb.openssh.authorizedKeys.keys;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
  services.tailscale.enable = true;

  services.mastodon = {
    enable = true;
    localDomain = "m.gianarb.it";
    configureNginx = true;
    smtp.fromAddress = "";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "ciao@gianarb.it";
  };

  networking.hostName = "beetroot";
  networking.firewall.checkReversePath = "loose";
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 80 443 ];
  };

  networking.interfaces.eth0.useDHCP = true;

  networking.interfaces.eth1 = {
    useDHCP = true;
    ipv4 = {
      addresses = [
        { address = "192.168.2.50"; prefixLength = 17; }
      ];
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
