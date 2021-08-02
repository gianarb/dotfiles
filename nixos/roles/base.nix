{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bintools-unwrapped
    utillinux
    stow
    wget
    vim
    git
    gitAndTools.gh
    tailscale
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
  ];

}

