{ config, lib, pkgs, ... }: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
