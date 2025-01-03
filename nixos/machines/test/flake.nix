{
  description = "My mastodon server running at m.gianarb.it";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    agenix.url = "github:ryantm/agenix";
    deploy-rs.url = "github:serokell/deploy-rs";
  };
  outputs = { self, nixpkgs, deploy-rs, agenix }: {
    nixosConfigurations = {
      mailinglist-qemu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./mailinglist-qemu-vm.nix
        ];
      };
    };
  };
}
