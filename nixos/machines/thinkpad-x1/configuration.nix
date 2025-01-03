# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
    ./hardware-configuration.nix
    ../../roles/desktop.nix

    ../../applications/tailscale.nix
    ../../applications/languagetool.nix
    ../../applications/gnome.nix
    ../../applications/qemu.nix
    ../../applications/nix.nix

    ../../users/gianarb
  ];

  services.tailscale.useRoutingFeatures = "client";
  services.ollama.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlay/overlay.nix { }) ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  networking.extraHosts = ''
  '';

  environment.systemPackages = [
    (pkgs.python312.withPackages(ps: with ps; [openpyxl]))
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "general" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
  };

  networking.hostName = "trenta"; # Define your hostname.
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };
  networking.firewall.enable = true;
  environment.pathsToLink = [ "/libexec" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  location.provider = "geoclue2";
  services.geoclue2.enable = true;
  programs.ssh.startAgent = true;
  services.fwupd.enable = true;
  services.udisks2.enable = true;

  environment.variables = {
    EDITOR = "vim";
    XCURSOR_PATH =
      lib.mkForce [ "${pkgs.gnome3.adwaita-icon-theme}/share/icons" ];
    TERMINAL = "alacritty";
  };

  services.logind.extraConfig = ''
    RuntimeDirectorySize=10G
  '';

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

  services.gvfs.enable = true;

  system.stateVersion = "20.09"; # Did you read the comment?
}
