# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
  nixos-hardware = import <nixos-hardware> { };
in
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
    ./hardware-configuration.nix
    ../../applications/i3.nix
    ../../applications/tailscale.nix
    ../../applications/qemu.nix
    ../../roles/desktop.nix
    ../../applications/nix.nix
    ../../users/gianarb
  ];

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk
      font-awesome
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlay/overlay.nix { }) ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  networking.hostName = "trenta"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  # This is the TCP port I want to use to reach my laptop in my internal network.
  networking.firewall.interfaces.enp5s0.allowedTCPPorts = [ 10123 ];

  # tailscale workaround https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.checkReversePath = "loose";

  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  programs.ssh.startAgent = true;
  services.fwupd.enable = true;

  environment.variables = {
    EDITOR = "vim";
    XCURSOR_PATH =
      lib.mkForce [ "${pkgs.gnome3.adwaita-icon-theme}/share/icons" ];
    TERMINAL = "alacritty";
  };

  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/"
        + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/"
        + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    serviceConfig = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  system.stateVersion = "20.09"; # Did you read the comment?
}
