{ config, pkgs, lib, ... }: {
  imports = [
    ../../roles/base.nix
    ../../users/gianarb
    ./klipper.nix
  ];

  environment.systemPackages = [
    (pkgs.klipper-firmware.override {
      gcc-arm-embedded = pkgs.gcc-arm-embedded-11;
    })
  ];

  services.klipper.settings.probe.z_offset = lib.mkForce 16.000;
  services.klipper.settings.delta_calibrate.horizontal_move_z = lib.mkForce 17.197;

  services.klipper.settings.delta_calibrate.height0 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height0_pos = lib.mkForce "35612.667,35612.667,35612.667";
  services.klipper.settings.delta_calibrate.height1 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height1_pos = lib.mkForce "41651.333,41651.333,32050.333";
  services.klipper.settings.delta_calibrate.height2 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height2_pos = lib.mkForce "34755.667,45279.667,34755.667";
  services.klipper.settings.delta_calibrate.height3 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height3_pos = lib.mkForce "32169.333,40578.000,40578.000";
  services.klipper.settings.delta_calibrate.height4 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height4_pos = lib.mkForce "34586.333,34586.333,42096.333";
  services.klipper.settings.delta_calibrate.height5 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height5_pos = lib.mkForce "39715.000,32422.333,39715.000";
  services.klipper.settings.delta_calibrate.height6 = lib.mkForce 17.197;
  services.klipper.settings.delta_calibrate.height6_pos = lib.mkForce "43607.000,34688.000,34688.000";

  services.klipper.settings.printer.minimum_z_position = lib.mkForce "-10";
  services.klipper.settings.printer.delta_radius = lib.mkForce 141.553523;

  services.klipper.settings.stepper_a.angle = lib.mkForce 210.181908;
  services.klipper.settings.stepper_a.arm_length = lib.mkForce 280.000000;
  services.klipper.settings.stepper_a.position_endstop = lib.mkForce 372.971746;

  services.klipper.settings.stepper_b.angle = lib.mkForce 329.784204;
  services.klipper.settings.stepper_b.arm_length = lib.mkForce 280.000000;
  services.klipper.settings.stepper_b.position_endstop = lib.mkForce 373.433577;

  services.klipper.settings.stepper_c.angle = lib.mkForce 90.000000;
  services.klipper.settings.stepper_c.arm_length = lib.mkForce 280.000000;
  services.klipper.settings.stepper_c.position_endstop = lib.mkForce 373.629930;

  users.users.root.openssh.authorizedKeys.keys = config.users.users.gianarb.openssh.authorizedKeys.keys;
  security.polkit.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "privileged_user" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  services.fwupd.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  time.timeZone = "Europe/Berlin";
  documentation.dev.enable = true;

  nix = {
    package = pkgs.nixVersions.stable;
    settings.sandbox = true;
    settings.system-features = [ "recursive-nix" ];
    settings.trusted-users = [ "gianarb" ];
    extraOptions = ''
      experimental-features = flakes
      builders-use-substitutes = true
    '';
    # Automatically garbage collect
    gc.automatic = true;
    gc.options = "--delete-older-than 10d";
  };

  services.moonraker = {
    user = "root";
    enable = true;
    address = "0.0.0.0";
    settings = {
      "power hass_switch"= {
        type = "homeassistant";
        protocol = "http";
        address = "192.168.1.5";
        port = 80;
        device = "switch.flsun";
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIxNDY0OTVhZjQ5MDc0YjNmYmYxNjQzYjdhYzQyODlkZCIsImlhdCI6MTcyMTQ5MTk4MiwiZXhwIjoyMDM2ODUxOTgyfQ.UXMN2mXaQPxYmLYamdVxKJ55LsSM99q_-Za38uwROY8";
        domain = "switch";
      };
      octoprint_compat = { };
      history = { };
      authorization = {
        force_logins = true;
        cors_domains = [
          "*.local"
          "*.lan"
        ];
        trusted_clients = [
          "127.0.0.0/8"
          "192.168.1.0/24"
        ];
      };
    };
  };

  services.fluidd = {
    enable = true;
    nginx = {
      locations."/webcam".proxyPass = "http://127.0.0.1:8080/stream";
    };
  };

  systemd.services.ustreamer = {
    wantedBy = [ "multi-user.target" ];
    description = "uStreamer for video0";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.ustreamer}/bin/ustreamer --encoder=HW --persistent --drop-same-frames=30'';
    };
  };
  system.stateVersion = "23.05";
}
