# Edit this configuration file to define what should be installed on 
# your system.  Help is available in the configuration.nix(5) man page 
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../roles/base.nix
    ../../applications/nix.nix
    ../../users/gianarb
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.root.openssh.authorizedKeys.keys = config.users.users.gianarb.openssh.authorizedKeys.keys;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
  services.tailscale.enable = true;

  services.mastodon = {
    enable = true;
    localDomain = "m.gianarb.it";
    configureNginx = true;
    smtp.fromAddress = "";
    extraConfig = {
      SINGLE_USER_MODE = "true";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "ciao@gianarb.it";
  };

  networking.hostName = "beetroot";
  networking.firewall.checkReversePath = "loose";
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 80 443 ];
  };

  networking.interfaces.eth0.useDHCP = true;

  networking.interfaces.eth1 = {
    useDHCP = true;
    ipv4 = {
      addresses = [
        { address = "192.168.2.50"; prefixLength = 17; }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    jq
  ];

  system.stateVersion = "22.05"; # Did you read the comment?
}
