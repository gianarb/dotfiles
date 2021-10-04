{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kubectl
    #cargo rustc rustfmt clippy gcc pkg-config openssl openssl.dev rls
    rustup gcc pkg-config openssl openssl.dev rls
    grpc-tools
    gdb
    #go
    linuxPackages.perf
  ];
  environment.variables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

}

