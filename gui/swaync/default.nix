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
      message = "gui/ironbar expects hyprland";
    }
  ];

  home.packages = [pkgs.swaynotificationcenter];

  nixpkgs.overlays = [
    (final: prev: {
      swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (final: prev: {
        version = "42b905095";
        patches = [];
        nativeBuildInputs =
          prev.nativeBuildInputs
          ++ [
            pkgs.cmake
            pkgs.sassc
          ];
        buildInputs =
          prev.buildInputs
          ++ [
            pkgs.pantheon.granite
          ];
        src = pkgs.fetchFromGitHub {
          owner = "ErikReider";
          repo = "SwayNotificationCenter";
          rev = "42b90509504cd18d2566ac24233c88ac3867d8d8";
          hash = "sha256-7QO9mA1mrZB08cOlQ4JcXn7yv4OAWAcMVPu04KXhsrw=";
        };
      });
    })
  ];

  systemd.user.services.swaync = {
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };

    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
    };

    Install.WantedBy = ["hyprland-session.target"];
  };

  xdg.configFile = {
    "swaync/config.json".source = impurity.link ./config.json;
    "swaync/style.css".source = impurity.link ./style.css;
  };
}
