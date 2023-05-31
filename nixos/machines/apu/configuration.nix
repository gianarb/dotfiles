# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  powerManagement.cpuFreqGovernor = "ondemand";
  services.acpid.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKy/Uk6P2qaDtZJByQ+7i31lqUAw9xMDZ5LFEamIe6l"
  ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "yes";
  };
  environment.systemPackages = [ pkgs.vim pkgs.pciutils pkgs.wirelesstools pkgs.iw ];

  networking.hostName = "apu";
  networking.usePredictableInterfaceNames = true;
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  networking.wlanInterfaces = {
    "wlan-station0" = { device = "wlp5s0"; };
    "wlan-ap0" = { device = "wlp5s0"; mac = "08:11:96:0e:08:0a"; };
  };

  networking.networkmanager.unmanaged = [ "interface-name:wlp*" ]
    ++ lib.optional config.services.hostapd.enable "interface-name:${config.services.hostapd.interface}";


  services.hostapd = {
    enable = true;
    interface = "wlan-ap0";
    hwMode = "g";
    ssid = "nix";
    wpaPassphrase = "ciaociao";
    countryCode = "IT";
    extraConfig = ''
      ieee80211ac=1
      wmm_enabled=1
      ignore_broadcast_ssid=1
      auth_algs=1
      wpa=2
      wpa_key_mgmt=WPA-PSK
      rsn_pairwise=CCMP
    '';
  };

  networking.interfaces."wlan-ap0".ipv4.addresses =
    lib.optionals config.services.hostapd.enable [{ address = "192.168.12.57"; prefixLength = 24; }];

  systemd.services.wifi-relay =
    let inherit (pkgs) iptables gnugrep;
    in
    {
      description = "iptables rules for wifi-relay";
      after = [ "dhcpd4.service" ];
      wantedBy = [ "multi-user.target" ];
      script = ''
        ${iptables}/bin/iptables -w -t nat -I POSTROUTING -s 192.168.12.0/24 ! -o wlan-ap0 -j MASQUERADE
        ${iptables}/bin/iptables -w -I FORWARD -i wlan-ap0 -s 192.168.12.0/24 -j ACCEPT
        ${iptables}/bin/iptables -w -I FORWARD -i wlan-ap0 -s 192.168.1.0/24 -j ACCEPT
        ${iptables}/bin/iptables -w -I FORWARD -i wlan-station0 -d 192.168.12.0/24 -j ACCEPT
        ${iptables}/bin/iptables -w -I FORWARD -i wlan-station0 -d 192.168.1.0/24 -j ACCEPT
      '';
    };


  services.dnsmasq = lib.optionalAttrs config.services.hostapd.enable {
    enable = true;
    extraConfig = ''
      interface=wlan-ap0
      bind-interfaces
      dhcp-range=192.168.12.200,192.168.12.254,24h
    '';
  };
  networking.firewall.allowedUDPPorts = lib.optionals config.services.hostapd.enable [ 53 67 ];
  services.haveged.enable = config.services.hostapd.enable;

  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.wlp5s0.useDHCP = lib.mkDefault false;
  networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  system.stateVersion = "22.05";
}

