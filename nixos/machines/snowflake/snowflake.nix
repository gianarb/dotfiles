{ config, pkgs, lib, modulesPath, ... }: with lib; {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "sd_mod" "sdhci_acpi" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub.device = "/dev/sda";
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
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "yes";
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


  ## Some useful options for setting up a new system
  services.getty.autologinUser = mkForce "root";

  networking.hostName = "snowflake";

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
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
      "fronius"
      "shelly"
      "roomba"
      "samsungtv"
      "backup"
      "blink"
      "brother"
      "energy"
      "integration"
      "input_boolean"
      "kodi"
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
    ];
    config = {
      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
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
      port = 53; # Port for incoming DNS Queries.
      upstream = {
        default = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        "192.168.1.5/24" = [
          "1.1.1.1"
          "8.8.8.8"
        ];
    };
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "1.1.1.1";
        ips = [ "1.1.1.1" "8.8.8.8" ];
      };
      customDNS = {
        customTTL = "1h";
        filterUnmappedTypes= true;
        mapping= {
          "assistant.home" = "192.168.1.5";
          "tt-rss.home" = "192.168.1.5";
        };
      };
      #Enable Blocking of certian domains.
      blocking = {
        blackLists = {
          #Adblocking
          ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
          #Another filter for blocking adult sites
          adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
          #You can add additional categories
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
    };
  };

  system.stateVersion = "22.05";
}
