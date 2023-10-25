{
  description = "Usb live";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }:
    {
      nixosConfigurations = {
        usb =
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ({ config, pkgs, lib, modulesPath, ... }: {
                imports = [
                  ../../roles/base.nix
                  ../../applications/nix.nix
                  ../../users/gianarb
                  (modulesPath + "/installer/cd-dvd/installation-cd-base.nix")
                ];
                services.getty.autologinUser = nixpkgs.lib.mkForce "root";
                isoImage.volumeID = lib.mkForce "id-live";
                isoImage.isoName = lib.mkForce "id-live.iso";

                networking.hostName = "live-usb";
                networking.networkmanager.enable = true;
                networking.wireless.enable = lib.mkForce false;
                networking.useDHCP = false;
                networking.interfaces.eth0.useDHCP = true;
                users.users.root.openssh.authorizedKeys.keys = config.users.users.gianarb.openssh.authorizedKeys.keys;
                services.openssh = {
                  enable = true;
                  settings = {
                    PasswordAuthentication = false;
                    KbdInteractiveAuthentication = false;
                  };
                };
              })
            ];
          };
      };
    };
}
