{
  description = "Flsun Klipper";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.flsun = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        {
            config.system.stateVersion = "22.05";
            build.sdImage.compressImage = false;
        }
        ./configuration.nix
      ];
    };
    nixosConfigurations.nuc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-hardware.nixosModules.intel-nuc-8i7beh
        ({ config, lib, pkgs, ... }: {
          #networking = {
            #interfaces.enp2s0.useDHCP = true;
          #};
         networking = {
           hostName = "lab";
           networkmanager.enable = true;
           useDHCP = false;
           firewall.allowedTCPPorts = [ 80 7125 8123 8081 8080 8088 ];
        };

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
          boot.initrd.kernelModules = [ ];
          boot.kernelModules = [ "kvm-intel" ];
          boot.extraModulePackages = [ ];
          boot.kernelPackages = pkgs.linuxPackages_latest;

          fileSystems."/" =
            {
              device = "/dev/disk/by-label/ROOT";
              fsType = "ext4";
            };

          fileSystems."/boot" =
            {
              device = "/dev/disk/by-label/BOOT";
              fsType = "vfat";
            };

          swapDevices = [{
            device = "/var/lib/swapfile";
            size = 24 * 1024;
          }];

          services.xserver.enable = true;
          services.xserver.desktopManager.kodi.enable = true;
          services.xserver.desktopManager.kodi.package = pkgs.kodi.withPackages (p: with p; [ kodi-platform youtube pvr-iptvsimple joystick ]);

          services.xserver.desktopManager.gnome.enable = true;

          services.displayManager.autoLogin.enable = true;
          services.displayManager.autoLogin.user = "kodi";
          services.xserver.displayManager.lightdm.autoLogin.timeout = 3;
          users.users.kodi = {
            isNormalUser = true;
            extraGroups = [ "video" "audio" ];
          };

          nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
          hardware.enableRedistributableFirmware = lib.mkDefault true;
          hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        })
        ./configuration.nix
      ];
    };
  };
}
