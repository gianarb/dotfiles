{ config, lib, pkgs, ... }: {
  boot.kernel.sysctl = {
    "vm.swappiness" = lib.mkDefault 1;
  };

  boot.tmpOnTmpfs = true;

  services.fstrim.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    htop
    tree
    bintools-unwrapped
    utillinux
    stow
    wget
    vim_configurable
    git
    gitAndTools.gh
    nmap
    tmux
    fzf
    ripgrep
    file
    jq
    direnv
    python3
    nixfmt
    gnumake
    nodejs-16_x
    unzip
    pciutils
    killall
  ];

}
