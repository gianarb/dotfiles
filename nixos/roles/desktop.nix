{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
    ./../applications/vscode.nix
    ./../applications/3dprinting.nix
    ./base.nix
    ./devtools.nix
  ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr2 pkgs.brlaser pkgs.hll2375dw-cups ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  hardware.bluetooth = {
    enable = true;
    settings.general.Enable = "Source,Sink,Media,Socket";
  };
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
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
    python39Packages.goobook
    zoom-us
    libreoffice
    alacritty
    weechat
    wireshark
    obs-studio
    spotify
    rnix-lsp
    remmina
  ];

}
