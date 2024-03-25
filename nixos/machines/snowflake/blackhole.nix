{ config, pkgs, lib, modulesPath, ... }: with lib;
{
  imports = [
    (modulesPath + "/installer/netboot/netboot-minimal.nix")
  ];

  boot.initrd.kernelModules = [ "dm-snapshot" "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKy/Uk6P2qaDtZJByQ+7i31lqUAw9xMDZ5LFEamIe6l"
  ];

  nix.settings.auto-optimise-store = true;

  ## Some useful options for setting up a new system
  services.getty.autologinUser = mkForce "root";

  system.build.myInit = pkgs.runCommand "init" { } ''
    mkdir -p $out
    echo -n "init=${config.system.build.toplevel}/init initrd=initrd loglevel=4" > $out/init
  '';

  networking.firewall.enable = false;
  networking.dhcpcd.enable = true;
  services.openssh.enable = true;

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "22.05";
}
