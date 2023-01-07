{ config, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  services.lorri.enable = true;
  environment.systemPackages = with pkgs; [
    kubectl
    unstable.rustup
    unstable.rust-analyzer
    pkgs.cargo-watch

    # useful to play with perf and framegraph in Rust context
    inferno
    cargo-flamegraph
    rust-analyzer

    gopls

    jq
    direnv
    nixfmt
    ripgrep
    nodejs-16_x
    fzf
    gitAndTools.gh
  ];
  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

}

