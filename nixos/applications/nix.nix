{ config, lib, pkgs, ... }: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
