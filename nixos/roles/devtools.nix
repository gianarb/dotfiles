{ config, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    age

    go
    gopls
    gotools

    jq
    direnv
    nix-direnv
    nixfmt
    ripgrep
    nodejs
    fzf
    gitAndTools.gh

    kubectl
    terraform
    terraform-ls
    kubectl
    azure-cli
    kind
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])

    cargo
    cargo-watch
    rustc
    rustfmt
    rust-analyzer

    process-compose
  ];
  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

}

