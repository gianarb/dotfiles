{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
  ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-label/swap"; }];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      name = "root";
      preLVM = true;
      allowDiscards = true;
    };
  };

}
