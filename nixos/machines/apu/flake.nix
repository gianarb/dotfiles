{
  description = "Apu is an AP router downstairs and everything else I want!";
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
      apu =
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
          ];
        };
    };
    deploy.nodes.apu = {
      hostname = "apu";
      sshUser = "root";

      profiles.system = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.nixos
          self.nixosConfigurations.apu;
      };
    };
  };
}
