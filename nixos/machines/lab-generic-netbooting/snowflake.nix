{ config, pkgs, lib, modulesPath, ... }: with lib; {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "sd_mod" "sdhci_acpi" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub.device = "/dev/sda";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKy/Uk6P2qaDtZJByQ+7i31lqUAw9xMDZ5LFEamIe6l"
  ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "yes";
  };


  environment.systemPackages = [ pkgs.pixiecore pkgs.lab.blackhole ];

  services.pixiecore.enable = true;
  services.pixiecore.openFirewall = true;
  services.pixiecore.debug = true;
  services.pixiecore.kernel = "${pkgs.lab.blackhole}/bzImage";
  services.pixiecore.initrd = "${pkgs.lab.blackhole}/initrd";
  #Ideally this is part of the ${blackhole-os}/netboot.ipxe
  #but I have no idea about how to pass it here just yet :(
  services.pixiecore.cmdLine = "init=/nix/store/dcpk1i1masymc199f6s48m9fizw9mlyb-nixos-system-nixos-22.05.20220902.67e4507/init initrd=initrd initrd=initrd loglevel=4";


  ## Some useful options for setting up a new system
  services.getty.autologinUser = mkForce "root";

  networking.dhcpcd.enable = true;
  networking.hostName = "snowflake";

  system.stateVersion = "22.05";
}
