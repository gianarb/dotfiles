{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kubectl
    rustup

    # useful to play with perf and framegraph in Rust context
    inferno
    cargo-flamegraph

    gcc
    pkg-config
    openssl
    openssl.dev
    rls
    protobuf
    gdb
    linuxPackages.perf
  ];
  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

}

