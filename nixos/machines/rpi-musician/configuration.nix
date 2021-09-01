{ inputs, lib, pkgs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware-configuration.nix
    ../../roles/base.nix
    ../../users/gianarb
    ../../users/dummy
  ];

  boot.loader.raspberryPi = {
    enable = true;
    version = 3;
  };

  networking.wireless.enable = true;
  networking.hostName = "musician"; # Define your hostname.
  # Set your time zone.
  time.timeZone = "Europe/Rome";

  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  programs.ssh.startAgent = true;
  programs.mosh.enable = true;
  services.openssh = {
    enable = true;
    challengeResponseAuthentication = false;
    permitRootLogin = lib.mkDefault "no";
  };

  environment.variables = {
    EDITOR = "vim";
    TERMINAL = "alacritty";
  };

  nix = {
    distributedBuilds = true;
    gc = { automatic = true; };
    package = pkgs.nixUnstable;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlay/overlay.nix { }) ];
}
