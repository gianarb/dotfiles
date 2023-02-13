{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05-small";
    deploy-rs.url = "github:serokell/deploy-rs";
  };
  outputs = { self, nixpkgs, deploy-rs }: {

    nixosConfigurations = {
      blackhole =
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./blackhole.nix
          ];
        };
      snowflake =
        let
          system = "x86_64-linux";
          overlay-lab = final: prev: {
            lab = self.packages.${prev.system};
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-lab ]; })
            ./snowflake.nix
          ];
        };
    };

    packages.x86_64-linux.blackhole = nixpkgs.legacyPackages.x86_64-linux.symlinkJoin {
      name = "blackhole";
      paths = with self.nixosConfigurations.blackhole.config.system.build; [
        netbootRamdisk
        kernel
        netbootIpxeScript
        myInit
      ];
    };

    deploy.nodes.snowflake = {
      hostname = "192.168.1.50";
      sshUser = "root";

      profiles.system = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.nixos
          self.nixosConfigurations.snowflake;
      };
    };
  };
}
