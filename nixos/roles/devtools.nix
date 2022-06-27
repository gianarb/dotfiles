{ config, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    kubectl
    rustup
    unstable.rust-analyzer

    # useful to play with perf and framegraph in Rust context
    inferno
    cargo-flamegraph
    rust-analyzer

    gcc
    pkg-config
    openssl
    openssl.dev
    protobuf
    gdb
    linuxPackages.perf
  ];
  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

}

