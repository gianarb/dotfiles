{
  # Nixifed version of this
  # https://github.com/CobraPi/Klipper-Firmware-FLSUN-QQ-S-Pro-Delta-Printer/blob/main/configurations/printer_qqs(Stock).cfg
  # Thanks a lot CobraPi for the hard work
  services.klipper = {
    user = "root";
    group = "root";
    enable = true;
    firmwares = {
      mcu = {
        enable = true;
        configFile = ./new.cfg;
        serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
      };
    };
    settings = {
      mcu = {
        serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
        restart_method = "command";
        baud = 250000;
      };

      display_status = { };

      pause_resume = { };

      printer = {
        kinematics = "delta";
        max_velocity = 500;
        max_accel = 2000;
        max_z_velocity = 200;
        minimum_z_position = -5;
        delta_radius = 130;
      };

      stepper_a = {
        step_pin = "PE3";
        dir_pin = "PE2";
        enable_pin = "!PE4";
        rotation_distance = 32;
        endstop_pin = "PA15";
        microsteps = 16;
        homing_speed = 60;
        position_endstop = 370;
        arm_length = 280.0;
      };

      stepper_b = {
        step_pin = "PE0";
        dir_pin = "PB9";
        enable_pin = "!PE1";
        rotation_distance = 32;
        endstop_pin = "PA12";
        microsteps = 16;
      };

      stepper_c = {
        step_pin = "PB5";
        dir_pin = "PB4";
        enable_pin = "!PB8";
        rotation_distance = 32;
        endstop_pin = "PC4";
        microsteps = 16;
      };

      probe = {
        pin = "!PA11";
        x_offset = 0;
        y_offset = 0;
        z_offset = 10;
        samples = 3;
        samples_result = "average";
        sample_retract_dist = 5;
      };

      delta_calibrate = {
        radius = 120;
        horizontal_move_z = 10;
      };

      extruder = {
        step_pin = "PD6";
        dir_pin = "!PD3";
        enable_pin = "!PB3";
        rotation_distance = 9;
        microsteps = 16;
        nozzle_diameter = 0.400;
        filament_diameter = 1.750;
        heater_pin = "PC3";
        sensor_type = "EPCOS 100K B57560G104F";
        sensor_pin = "PC1";
        control = "pid";
        pid_Kp = 14.529;
        pid_Ki = 0.557;
        pid_Kd = 94.802;
        min_extrude_temp = 180;
        min_temp = 0;
        max_temp = 260;
      };

      heater_bed = {
        heater_pin = "PA0";
        sensor_type = "EPCOS 100K B57560G104F";
        sensor_pin = "PC0";
        control = "pid";
        pid_Kp = 325.10;
        pid_Ki = 63.35;
        pid_Kd = 417.10;
        min_temp = 0;
        max_temp = 150;
      };

      fan = {
        pin = "PB1";
        kick_start_time = 0.200;
      };

      virtual_sdcard.path = "/var/lib/moonraker/gcodes";

      #######################################################################
      # Optional: Bed mesh leveling - only use if the PROBE_ACCURACY
      #                               command outputs a range value < 0.025 mm
      #######################################################################

      #[bed_mesh]
      #speed: 50
      #horizontal_move_z: 35
      #mesh_radius: 100
      #mesh_origin: 0,0
      #round_probe_count: 5
      #algorithm: lagrange

      "gcode_macro START_PRINT".gcode = "
        SET_GCODE_OFFSET Z_ADJUST=-0.1 MOVE=1 # sets the z-offset
      ";
      "gcode_macro END_PRINT".gcode = "
        SET_GCODE_OFFSET Z_ADJUST=0
        G28
      ";
      "gcode_macro PAUSE" = {
        gcode = "
          SAVE_GCODE_STATE NAME=PAUSE_state
          BASE_PAUSE
          G91
          G1 E-{params.E|default(1)} F2100 ; change 1 to your default retraction distance
          G1 Z{params.Z|default(10)} ; change 10 to your Z parking position
          G90
          G1 X{params.X|default(230)} Y{params.Y|default(230)} F6000 ; change 230 to your X and Y parking postiob
        ";
        rename_existing = "BASE_PAUSE";
      };
      "gcode_macro RESUME" = {
        gcode = "
          G91
          G1 E{params.E|default(1)} F2100 ; change 1 to your default retraction distance
          G90
          RESTORE_GCODE_STATE NAME=PAUSE_state MOVE=1
          BASE_RESUME
        ";
        rename_existing = "BASE_RESUME";
      };
      "gcode_macro CANCEL_PRINT" = {
        gcode = "
          TURN_OFF_HEATERS
          CLEAR_PAUSE
          SDCARD_RESET_FILE
          BASE_CANCEL_PRINT
        ";
        rename_existing = "BASE_CANCEL_PRINT";
      };
    };
  };
}
