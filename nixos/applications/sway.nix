{ config, lib, pkgs, ... }: {
  services.xserver.displayManager.sessionPackages = [ pkgs.sway ];
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wdisplays
      wl-clipboard
      xwayland
      i3blocks
      hicolor-icon-theme
      qgnomeplatform
      xdg_utils
    ];
  };
}
