{ config, pkgs, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  services.tailscale.enable = true;
  services.tailscale.package = unstable.tailscale;

  # tailscale workaround https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.checkReversePath = "loose";

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  environment.systemPackages = with pkgs; [ unstable.tailscale ];
}
