{
  config,
  pkgs,
  ...
}: let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = [ pkgs.grim pkgs.satty pkgs.slurp ];
    text = ''
      set -e
      grim -g "$(slurp)" - | satty \
        --filename - \
        --output-filename "${config.home.homeDirectory}/screenshots/%Y%m%d%H%M%S.png"
    '';
  };
in {
  assertions = [
    {
      assertion = let
        cfg = config.wayland.windowManager.hyprland;
      in
        cfg.enable && cfg.systemd.enable;
      message = "gui/screenshot expects hyprland";
    }
  ];

  home.packages = [ screenshot ];

  wayland.windowManager.hyprland.settings."$screenshot" = "${screenshot}";
}
