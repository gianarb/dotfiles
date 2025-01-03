{ pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; [
    age
    unstable.aider-chat
    lua-language-server

    pylyzer

    go
    gopls
    gotools
    delve

    unstable.svelte-language-server

    jq
    direnv
    nix-direnv
    nixfmt-classic
    nil
    ripgrep
    unstable.neovim
    unstable.ghostty
    nodejs
    fzf
    gitAndTools.gh

    kubectl
    k9s
    terraform
    terraform-ls
    kubectl
    azure-cli
    kind
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])

    redis

    cargo
    cargo-watch
    rustc
    rustfmt
    rust-analyzer

    unstable.process-compose
  ];
  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

}

