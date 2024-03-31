{
  config,
  foos,
  inputs,
  pkgs,
  ...
}: {
  assertions = [
    {
      assertion = let
        cfg = config.wayland.windowManager.hyprland;
      in
        cfg.enable && cfg.systemd.enable;
      message = "gui/lock expects hyprland";
    }
  ];

  systemd.user = {
    services = {
      swaylock = {
        Unit = {
          OnSuccess = "unlock.target";
          PartOf = "lock.target";
          After = "lock.target";
        };

        Service = {
          Type = "forking";
          ExecStart = "${pkgs.swaylock-effects}/bin/swaylock -f";
          Restart = "on-failure";
          RestartSec = "0";
        };

        Install.WantedBy = ["lock.target"];
      };

      systemd-lock-handler = {
        Service = {
          Slice = "session.slice";
          ExecStart = "${pkgs.systemd-lock-handler}/lib/systemd-lock-handler";
          Type = "notify";
          Restart = "on-failure";
          RestartSec = "10s";
        };

        Install.WantedBy = ["default.target"];
      };

      swayidle = {
        Unit = {
          PartOf = "graphical-session.target";
          After = "graphical-session-pre.target";
        };

        Service = let
          start-swayidle = pkgs.writeShellApplication {
            name = "start-swayidle";
            runtimeInputs = [
              pkgs.brightnessctl
              inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
              pkgs.systemd # for loginctl
            ];
            text = ''
              "${pkgs.swayidle}/bin/swayidle"
            '';
          };
        in {
          ExecStart = "${start-swayidle}/bin/start-swayidle";
        };

        Install.WantedBy = ["hyprland-session.target"];
      };
    };

    targets = {
      lock.Unit.Conflicts = "unlock.target";
      sleep.Unit = {
        Requires = "lock.target";
        After = "lock.target";
      };
      unlock.Unit.Conflicts = "lock.target";
    };
  };

  xdg.configFile = {
    "swayidle/config".source = foos pkgs ./swayidle.config;
    "swaylock/config".source = foos pkgs ./swaylock.config;
  };
}
