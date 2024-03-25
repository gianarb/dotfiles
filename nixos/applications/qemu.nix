{ config, pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  virtualisation.libvirtd.onShutdown = "shutdown";
}
