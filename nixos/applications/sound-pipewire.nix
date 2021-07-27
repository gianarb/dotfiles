{ config, pkgs, ... }: {
  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
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
