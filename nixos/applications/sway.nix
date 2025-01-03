{ pkgs, ... }:
{
  systemd.user.sockets.pipewire.wantedBy = [ "sockets.target" ];
  programs.light.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      mako
      grim
      xdg-utils
      wdisplays
      wl-clipboard
      i3blocks
      hicolor-icon-theme
      qgnomeplatform
    ];
  };
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };
}

