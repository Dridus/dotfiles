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
      message = "wayland/hyprpaper expects hyprland";
    }
  ];

  systemd.user.services.hyprpaper = {
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };

    Service.ExecStart = let
      hyprpaper = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in "${hyprpaper}/bin/hyprpaper";

    Install.WantedBy = ["hyprland-session.target"];
  };

  xdg.configFile."hypr/hyprpaper.conf".source = foos pkgs ./hyprpaper.conf;
}
