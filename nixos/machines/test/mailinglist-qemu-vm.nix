{
  pkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-24.05.tar.gz"){}
}: pkgs.nixosSystem {
  system = "x86_64-linux";
  modules = [
    (pkgs+"nixos/nixos/modules/virtualisation/qemu-vm.nix")
    ./../../modules/mailinglist.nix

    ({ pkgs, modulesPath, ... }: {
      services.getty.autologinUser = pkgs.lib.mkForce "root";
      imports = [
        ../../roles/base.nix
        ../../applications/nix.nix
        ../../users/gianarb
      ];
      networking.hostName = "mailmanager";
      networking.firewall.allowedTCPPorts = [ 25 80 443 ];
      environment.systemPackages = [];

    })
  ];
}
