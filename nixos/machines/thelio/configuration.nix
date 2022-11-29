# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../applications/i3.nix
    ../../applications/tailscale.nix
    ../../applications/qemu.nix
    ../../applications/sound-pipewire.nix
    ../../roles/desktop.nix
    ../../applications/nix.nix
    ../../users/gianarb
  ];
  environment.systemPackages = with pkgs; [
    pkgs.linuxPackages.system76-power
    pkgs.rssnix
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

  services.upower.enable = true;

  services.openssh.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # tailscale workaround https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.checkReversePath = "loose";

  # Use the systemd-boot EFI boot loader.

  networking.hostName = "huge"; # Define your hostname.
  networking.networkmanager.enable = true;

  # This is the TCP port I want to use to reach my laptop in my internal network.
  networking.firewall.interfaces.enp5s0.allowedTCPPorts = [ 10123 ];

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.grub.device = "nodev";
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.efiSupport = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  programs.ssh.startAgent = true;

  programs.dconf.enable = true;
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  environment.pathsToLink = [ "/libexec" ];

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  services.fwupd.enable = true;

  environment.variables = {
    EDITOR = "vim";
    XCURSOR_PATH =
      lib.mkForce [ "${pkgs.gnome3.adwaita-icon-theme}/share/icons" ];
    TERMINAL = "alacritty";
  };

  systemd.services.system76-power-daemon = {
    description = "System76 Power Daemon";
    wantedBy = [ "basic.target" ];
    serviceConfig = {
      ExecStart = "${unstable.linuxPackages_latest.system76-power}/bin/system76-power daemon";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      ProtectSystem = "full";
    };
  };

  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/"
        + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw
      + pkgs.qt5.qtbase.qtQmlPrefix";
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

  nix = {
    useSandbox = true;
    distributedBuilds = true;
    gc = { automatic = true; };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlay/overlay.nix { }) ];

  # This value determines the NixOS release from which thedefault
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  programs.fuse.userAllowOther = true;

}
