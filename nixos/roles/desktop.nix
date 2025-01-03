{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
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


  services.upower.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr2 pkgs.brlaser pkgs.hll2375dw-cups ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.dbus.enable = true;
  services.power-profiles-daemon.enable = true;
  services.accounts-daemon.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.general.Enable = "Source,Sink,Media,Socket";
  };
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluez;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # https://nixos.wiki/wiki/PCManFM
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  environment.systemPackages = with pkgs; [
    ncurses
    zlib
    lldb
    dunst
    libnotify
    acpi
    alsaUtils
    pavucontrol
    usbutils
    xclip
    feh
    cifs-utils
    pcmanfm
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
    unstable.brave
    keepassxc
    brightnessctl
    calibre
    unstable.aerc
    #unstable.orca-slicer
    orca-slicer
    unstable.freecad
    zoom-us
    libreoffice
    alacritty
    weechat
    wireshark

    (wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
            obs-backgroundremoval
        ];
    })
    spotify
    nil
    remmina
    drawio
  ];

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };

}
