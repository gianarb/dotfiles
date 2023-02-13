# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
  nixos-hardware = import <nixos-hardware> { };
in
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
    ./hardware-configuration.nix
    ../../applications/i3.nix
    ../../applications/tailscale.nix
    ../../applications/qemu.nix
    ../../roles/desktop.nix
    ../../applications/nix.nix
    ../../users/gianarb
  ];

}
