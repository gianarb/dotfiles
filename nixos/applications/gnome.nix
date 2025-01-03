{ lib, pkgs, ... }:
{
  services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = lib.mkForce false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "gianarb";
  };
}
