{ config, lib, pkgs, ... }: {
  services.xserver.displayManager.sessionPackages = [ pkgs.sway ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      mako
      xdg-utils
      wdisplays
      wl-clipboard
      xwayland
      i3blocks
      hicolor-icon-theme
      qgnomeplatform
    ];
  };
}
