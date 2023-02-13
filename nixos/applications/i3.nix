{ config, lib, pkgs, ... }: {
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  services.autorandr.enable = true;

  services.xserver = {
    enable = true;

    libinput.enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        xorg.libXcomposite # this should make drawing with Slak possible
        arandr
        autorandr
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
  };
}
