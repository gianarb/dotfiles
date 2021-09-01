{ config, inputs, lib, pkgs, ... }:
with lib;
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gianarb = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    extraGroups = [
      "root"
      "wheel"
      "networkmanager"
      "video"
      "dbus"
      "audio"
      "sound"
      "pulse"
      "input"
      "lp"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKy/Uk6P2qaDtZJByQ+7i31lqUAw9xMDZ5LFEamIe6l"
    ];
  };
}
