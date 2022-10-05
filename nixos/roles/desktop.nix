{ config, lib, pkgs, ... }: {
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
    feh
    gnome3.nautilus
    networkmanagerapplet
    gnomeExtensions.appindicator
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
    aerc
    python39Packages.goobook
    zoom-us
    libreoffice
    alacritty
    slack
    weechat
    wireshark
    obs-studio
    spotify
    rnix-lsp
    remmina
  ];

}
