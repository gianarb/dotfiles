{ config, lib, pkgs, ... }: {
    imports = [
      ./base.nix
    ];
  environment.systemPackages = with pkgs; [
    dunst
    acpi
    gnome3.nautilus
  gnome3.networkmanagerapplet
  gnomeExtensions.appindicator
  scrot
  blueman
  pavucontrol
  adwaita-qt
  gnome3.adwaita-icon-theme

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

