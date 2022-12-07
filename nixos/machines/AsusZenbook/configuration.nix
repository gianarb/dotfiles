# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../applications/i3.nix
    ../../applications/tailscale.nix
    ../../applications/sound-pipewire.nix
    ../../roles/desktop.nix
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

  services.udev.extraRules = ''
      # keyboard disable autosuspand
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="04b4", ATTR{idProduct}=="6001", ATTR{power/autosuspend}="-1"
    # mouse disable autosuspand
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1bcf", ATTR{idProduct}=="0005", ATTR{power/autosuspend}="-1"
  '';


  # Set your time zone.
  time.timeZone = "Europe/Rome";

  networking.hostName = "dieci"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  # This is the TCP port I want to use to reach my laptop in my internal network.
  networking.firewall.interfaces.enp5s0.allowedTCPPorts = [ 10123 ];

  # tailscale workaround https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.checkReversePath = "loose";


  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  programs.ssh.startAgent = true;

  programs.dconf.enable = true;
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  environment.pathsToLink = [ "/libexec" ];

  virtualisation.docker.enable = true;

  services.fwupd.enable = true;

  services = {
    clamav = {
      daemon. enable = true;
      updater.enable = true;
    };
  };

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

  nix = {
    useSandbox = true;
    distributedBuilds = true;
    gc = { automatic = true; };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlay/overlay.nix { }) ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  # https://nixos.org/manual/nixos/stable/index.html#sec-upgrading-automatic
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

}
