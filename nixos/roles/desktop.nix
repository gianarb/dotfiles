{ config, lib, pkgs, ... }: {
  imports = [ 
    ./base.nix
    ./devtools.nix
  ];
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
    acpi
    alsaUtils
    pulseaudio
    pavucontrol
    usbutils
    xclip
    gnome3.nautilus
    gnome3.networkmanagerapplet
    gnomeExtensions.appindicator
    scrot
    blueman
    adwaita-qt
    gnome3.adwaita-icon-theme
    vlc
    dropbox-cli
    brave
    keepassxc
    brightnessctl
    aerc
    zoom-us
    alacritty
    slack
    weechat
    obs-studio

    rnix-lsp
  ];
}

