# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../applications/i3.nix
    ../../applications/sound-pulse.nix
    ../../roles/desktop.nix
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

  # Use the systemd-boot EFI boot loader.

  networking.hostName = "dieci"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  services.printing.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.general.Enable = "Source,Sink,Media,Socket";
  };
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gianarb = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    extraGroups = [
        "root"
        "wheel"
        "networkmanager"
        "video"
        "dbus"
        "audio"
        "sound"
        "pulse"
        "input"
        "lp"
        "docker"
        ];
  };

  environment.pathsToLink = [ "/libexec" ];

  virtualisation.docker.enable = true;

  services.tailscale.enable = true;

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

  nix = {
    useSandbox = true;
    distributedBuilds = true;
    gc = { automatic = true; };
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

}
