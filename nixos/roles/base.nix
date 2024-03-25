{ config, lib, pkgs, ... }: {
  networking.firewall.allowPing = true;

  environment.systemPackages = with pkgs;
    [
      htop
      tree
      bintools-unwrapped
      utillinux
      stow
      wget
      vim_configurable
      git
      nmap
      tmux
      file
      bind
      python311
      gnumake
      unzip
      zip
      pciutils
      killall
    ];

}
