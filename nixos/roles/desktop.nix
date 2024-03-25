{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
    ./../applications/3dprinting.nix
    ./base.nix
    ./devtools.nix
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk
      font-awesome
    ];
  };


  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr2 pkgs.brlaser pkgs.hll2375dw-cups ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.dbus.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.general.Enable = "Source,Sink,Media,Socket";
  };
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluez;

  # Enable sound.
  hardware.pulseaudio.enable = true;
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    arduino
    ncurses
    zlib
    lldb
    dunst
    libnotify
    acpi
    alsaUtils
    pulseaudio
    pavucontrol
    usbutils
    xclip
    rssnix
    feh
    gnome3.nautilus
    networkmanagerapplet
    gnomeExtensions.appindicator
    xournal
    scrot
    signal-desktop
    blueman
    adwaita-qt
    gnome3.adwaita-icon-theme
    gcalcli
    gparted
    vlc
    dropbox-cli
    brave
    keepassxc
    brightnessctl
    calibre
    unstable.aerc
    zoom-us
    libreoffice
    alacritty
    weechat
    wireshark
    obs-studio
    spotify
    bruno
    nil
    remmina
    drawio
  ];

}
