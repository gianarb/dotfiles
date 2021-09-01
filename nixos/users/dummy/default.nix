{ config, inputs, lib, pkgs, ... }:
with lib;
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dummy = {
    isNormalUser = true;
    uid = 1111;
    password = "dummy";
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
  };
}
