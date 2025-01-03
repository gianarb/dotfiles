{ config , pkgs, lib, modulesPath, ... }: let
in {

  imports = [
    ../../roles/base.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "sd_mod" "sdhci_acpi" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub.device = "/dev/sda";
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKy/Uk6P2qaDtZJByQ+7i31lqUAw9xMDZ5LFEamIe6l"
  ];

  services.openssh = {
    enable = true;
    settings = { 
        PermitRootLogin = "yes";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
    };
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      UPTIME_KUMA_PORT = "4100";
      UPTIME_KUMA_HOST = "127.0.0.1";
    };
  };

  networking.firewall.enable = false;
  environment.systemPackages = [ pkgs.pixiecore pkgs.lab.blackhole ];

  services.pixiecore.enable = true;
  services.pixiecore.openFirewall = true;
  services.pixiecore.debug = true;
  services.pixiecore.port = 801;
  services.pixiecore.statusPort = 801;
  services.pixiecore.kernel = "${pkgs.lab.blackhole}/bzImage";
  services.pixiecore.initrd = "${pkgs.lab.blackhole}/initrd";
  services.pixiecore.cmdLine = lib.readFile "${pkgs.lab.blackhole}/init";

  services.tailscale.enable = true;

  ## Some useful options for setting up a new system
  services.getty.autologinUser = lib.mkForce "root";

  networking.hostName = "snowflake";

  security.acme = {
    acceptTerms = true;
    defaults.email = "ciao@gianarb.it";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."uptime.gianarb.it" = {
      #addSSL = true;
      #enableACME = true;
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:4100";
        proxyWebsockets = true;
      };
    };
    virtualHosts."assistant.home" = {
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://[::1]:8123";
        proxyWebsockets = true;
      };
    };
  };

  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
      "google_translate"
      # "fronius" currently broken
      "shelly"
      "roomba"
      "samsungtv"
      "backup"
      "blink"
      "dhcp"
      "default_config"
      "zeroconf"
      "zha"
      "brother"
      "energy"
      "integration"
      "input_boolean"
      "kodi"

      "mqtt"
      "mqtt_eventstream"
      "mqtt_json"
      "mqtt_room"
      "mqtt_statestream"

      "ipp"
    ];
    customComponents = [
      pkgs.unstable.home-assistant-custom-components.moonraker
    ];
    extraPackages = python3Packages: with python3Packages; [
      aiovodafone
      moonraker-api
      pyipp
      gtts
      zlib-ng
      isal
    ];
    config = {
      homeassistant = {
        unit_system = "metric";
        time_zone = "Europe/Rome";
        temperature_unit = "C";
        name = "Home";
      };
      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      "scene ui" = "!include scenes.yaml";
      "script ui" = "!include scripts.yaml";
      "automation ui" = "!include automations.yaml";
    };
  };

  services.zigbee2mqtt = {
    package = pkgs.unstable.zigbee2mqtt;
    enable = true;
    settings = {
      availability = {
        active = {
          timeout = 10;
        };
        passive = {
          timeout = 1500;
        };
      };
      advanced = {
        log_level = "debug";
      };
      external_converters = [
        "TZE204_myd45weu.js"
      ];
      frontend = true;
      homeassistant = config.services.home-assistant.enable;
      permit_join = true;
      serial = {
        adapter = "ember";
        port = "/dev/ttyACM0";
      };
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  services.tt-rss = {
    enable = true; # Enable TT-RSS
    database = {
      type = "pgsql"; # Database type
      password = "";
    };
    email = {
      fromAddress = "news@mydomain"; # Address for outgoing email
      fromName = "News at mydomain"; # Display name for outgoing email
    };
    selfUrlPath = "http://tt-rss.home/"; # Root web URL
    virtualHost = "tt-rss.home";
    plugins = ["bookmarklets" "auth_internal" "note"];
    singleUserMode = true;
    extraConfig = ''
      putenv('HTTP_PORT=8280');
    '';
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "general" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      local tt_rss all ident map=tt_rss-users

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
    identMap = # Map the tt-rss user to postgresql
      ''
        tt_rss-users tt_rss tt_rss
      '';
  };

  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53;
        http = 4000;
      };
      upstream = {
        default = ["8.8.8.8"];
      };
      blocking = {
        blackLists = {
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
        };
        clientGroupsBlock = {
          default = ["ads"];
        };
      };
      customDNS = {
        customTTL = "1h";
        filterUnmappedTypes= true;
        mapping= {
          "assistant.home" = "192.168.1.5";
          "tt-rss.home" = "192.168.1.5";
        };
      };
      #ports = {
        #dns = 53;
      #};
      #upstreams = {
        #groups = {
          #default = [
            #"1.1.1.1"
          #];
        #};
      #};
      #conditional = {
        #mapping = {
          #home = "192.168.1.5";
        #};
      #};
      #customDNS = {
        #customTTL = "1h";
        #filterUnmappedTypes= false;
        #mapping= {
          #"assistant.home" = "192.168.1.5";
          #"tt-rss.home" = "192.168.1.5";
        #};
      #};
      #blocking = {
        #blackLists = {
          #ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
        #};
        #clientGroupsBlock = {
          #default = ["ads"];
        #};
      #};
    };
  };

  system.stateVersion = "22.05";
}
