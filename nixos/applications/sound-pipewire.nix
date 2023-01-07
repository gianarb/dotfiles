{ config, pkgs, lib, ... }: {
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    package = pkgs.pipewire.overrideAttrs ({ patches ? [ ], ... }: {
      patches = [ ./../patches/ASUS_Zenbook_UX390.patch ] ++ patches;
    });
    config = {
      pipewire."context.properties"."default.clock.rate" = "192000";
      pipewire-pulse."stream.properties"."resample.quality" = 15;
      client."stream.properties"."resample.quality" = 15;
      client-rt."stream.properties"."resample.quality" = 15;
    };
    media-session.config.bluez-monitor.properties = {
      "bluez5.headset-roles" = [ "hsp_hs" "hsp_ag" ];
      "bluez5.codecs" = [ "aac" "ldac" "aptx_hd" ];
    };
  };


  systemd.services.bluethoot.serviceConfig.ExecStart = [
    ""
    "${config.hardware.bluetooth.package}/libexec/bluetooth/bluetoothd --noplugin=sap"
  ];
}
