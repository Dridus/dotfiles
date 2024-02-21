{
  impurity,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit
    (builtins)
    attrNames
    ;
  inherit
    (lib)
    concatStringsSep
    mapAttrsToList
    ;

  system = pkgs.stdenv.hostPlatform.system;

  compatibilityEnvs = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    JDK_JAVA_OPTIONS = concatStringsSep " " [
      "-Dawt.useSystemAAFontSettings=on"
      "-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
      "-Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
    ];
    CLUTTER_BACKEND = "wayland";
    NIXOS_OZONE_WL = "1";
    XCURSOR_SIZE = "24";
  };
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  config = {
    systemd.user.services = {
      polkit-gnome-authentication-agent-1 = {
        Unit = {
          PartOf = ["graphical-session.target"];
          After = ["graphical-session-pre.target"];
        };

        Service = {
          ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        };

        Install.WantedBy = ["hyprland-session.target"];
      };

    };

    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        inputs.hy3.packages.${system}.default
        # inputs.hyprfocus.packages.${system}.default
        # inputs.hyprland-plugins.packages.${system}.hyprbars
      ];
      settings = {
        env = mapAttrsToList (k: v: "${k},${v}") compatibilityEnvs;
        "$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";
      };
      extraConfig = "source = ./settings.conf";
      systemd = {
        enable = true;
        variables =
          [
            "DISPLAY"
            "HYPRLAND_INSTANCE_SIGNATURE"
            "WAYLAND_DISPLAY"
            "XDG_CURRENT_DESKTOP"
          ]
          ++ attrNames compatibilityEnvs;
      };
    };

    xdg.configFile."hypr/settings.conf".source = impurity.link ./settings.conf;
  };
}
