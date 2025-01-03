# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  powerManagement.cpuFreqGovernor = "ondemand";


  boot.kernelParams = [ "console=ttyS0,115200n8" ];
  boot.loader.grub.extraConfig = "
    serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1
    terminal_input serial
    terminal_output serial
  ";

  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.wlan0.useDHCP = lib.mkDefault true;
  networking.interfaces.eth0.useDHCP = lib.mkDefault true;
  networking.interfaces.eth1.useDHCP = lib.mkDefault true;
  networking.interfaces.eth2.useDHCP = lib.mkDefault true;
  networking.interfaces.eth3.useDHCP = lib.mkDefault true;
  networking.wireless.enable = true;

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1; # Enable package forwarding.
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  swapDevices = [{ device = "/.swapfile"; size = 1024; }];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
