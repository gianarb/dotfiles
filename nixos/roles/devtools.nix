{ config, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    kubectl
    unstable.rustup
    unstable.rust-analyzer
    pkgs.cargo-watch

    # useful to play with perf and framegraph in Rust context
    inferno
    cargo-flamegraph
    rust-analyzer

    gcc
    autoconf
    pkg-config
    c-ares
    automake
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

