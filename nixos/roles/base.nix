{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
    python3
    gnumake
    unzip
    zip
    pciutils
    killall
  ];

}
