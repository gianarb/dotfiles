{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  #system.replaceRuntimeDependencies = [
    #({ original = pkgs.mesa; replacement = unstable.mesa; })
    #({ original = pkgs.mesa.drivers; replacement = unstable.mesa.drivers; })
  #];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  programs.xwayland.enable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.extraModulePackages = [ ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_6_11;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/root";
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
