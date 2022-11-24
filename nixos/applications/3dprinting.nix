{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cura
    freecad
  ];
}

