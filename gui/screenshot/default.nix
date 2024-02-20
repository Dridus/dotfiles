{
  config,
  impurity,
  pkgs,
  ...
}: {
  assertions = [
    {
      assertion = let
        cfg = config.wayland.windowManager.hyprland;
      in
        cfg.enable && cfg.systemd.enable;
      message = "gui/anyrun expects hyprland";
    }
  ];

  home.packages = [
    pkgs.satty
  ];

  wayland.windowManager.hyprland.settings."$screenshot" = "${pkgs.satty}/bin/satty --output-filename ${config.home.homeDirectory}/screenshots/%Y%m%d";

  xdg.configFile."satty/config.toml".source = impurity.link ./config.toml;
}
