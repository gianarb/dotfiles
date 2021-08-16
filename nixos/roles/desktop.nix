{ config, lib, pkgs, ... }: {
  imports = [ 
    ./base.nix
    ./devtools.nix
  ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr2 ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  hardware.bluetooth = {
    enable = true;
    settings.general.Enable = "Source,Sink,Media,Socket";
  };
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;


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
    spotify

    rnix-lsp
  ];
}

