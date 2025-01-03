{ config, ... }:
let
  unstable = import <unstable> { config = { allowUnfree = true; }; };
in
{
  services.resolved.enable = true;
  networking.useNetworkd = true;
  networking.useDHCP = false;

  services.tailscale = {
    enable = false;
    package = unstable.tailscale;
    useRoutingFeatures = "both";
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  environment.systemPackages = [ unstable.tailscale ];
}
