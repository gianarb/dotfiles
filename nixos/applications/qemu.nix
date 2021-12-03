{ config, pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = [ pkgs.virtmanager ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  virtualisation.libvirtd.onShutdown = "shutdown";
}
