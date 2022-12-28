{
  description = "My mastodon server running at m.gianarb.it";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    agenix.url = "github:ryantm/agenix";
    deploy-rs.url = "github:serokell/deploy-rs";
  };
  outputs = { self, nixpkgs, deploy-rs, agenix }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages."x86_64-linux".mkShell {
      buildInputs = [
        deploy-rs.packages.x86_64-linux.deploy-rs
        agenix.packages.x86_64-linux.agenix
      ];
    };
    nixosConfigurations = {
      production =
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
          ];
        };
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, modulesPath, ... }: {
            services.getty.autologinUser = nixpkgs.lib.mkForce "root";
          })
          ./configuration.nix
        ];
      };
    };
    deploy.nodes.beetroot = {
      hostname = "139.162.167.171";
      sshUser = "root";

      profiles.system = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.nixos
          self.nixosConfigurations.production;
      };
    };
  };
}

