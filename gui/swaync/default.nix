{ config, pkgs, ... }: {
  assertions = [
    {
      assertion = let
        cfg = config.wayland.windowManager.hyprland;
      in cfg.enable && cfg.systemd.enable;
      message = "gui/ironbar expects hyprland";
    }
  ];


  home.packages = [ pkgs.swaynotificationcenter ];

  systemd.user.services.swaync = {
    Unit = {
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
    };

    Install.WantedBy = [ "hyprland-session.target" ];
  };
}
