{ ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
    ./configuration.nix
  ];
}
