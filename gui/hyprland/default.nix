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
  };
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  config = {
    nixpkgs.overlays = [
      (final: prev: {
        xdg-desktop-portal-hyprland = inputs.xdg-desktop-portal-hyprland.packages.${system}.default;
      })
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        inputs.hy3.packages.${system}.default
        inputs.hyprfocus.packages.${system}.default
        # inputs.hyprland-plugins.packages.${system}.hyprbars
      ];
      settings.env = mapAttrsToList (k: v: "${k},${v}") compatibilityEnvs;
      extraConfig = ''
        $fileManager = ${pkgs.gnome.nautilus}/bin/nautilus
        $menu = wofi --show drun
        $terminal = ${pkgs.wezterm}/bin/wezterm start --always-new-process
        source = ${impurity.link ./settings.conf}
      '';
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

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };

      Service = {
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      };

      Install.WantedBy = ["hyprland-session.target"];
    };

    xdg = {
      portal = {
        enable = true;

        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-hyprland
        ];

        config.common = {
          default = ["hyprland"];
          "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        };
      };
    };
  };
}
