{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  portalPkgs = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];

  portalEnv = pkgs.buildEnv {
    name = "xdg-portals";
    paths = portalPkgs;
    pathsToLink = [
      "/share/xdg-desktop-portal/portals"
      "/share/applications"
    ];
  };
in {
  home.packages =
    [
      pkgs.xdg-desktop-portal
    ]
    ++ portalPkgs;

  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal-hyprland = inputs.xdg-desktop-portal-hyprland.packages.${system}.default;
    })
  ];

  systemd.user.services.xdg-desktop-portal = {
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };

    Service = {
      Environment = [
        "XDG_DESKTOP_PORTAL_DIR=${portalEnv}/share/xdg-desktop-portal/portals"
      ];
      Type = "dbus";
      BusName = "org.freedesktop.portal.Desktop";
      ExecStart = "${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal";
      Slice = "session.slice";
    };
  };

  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=hyprland
    org.freedesktop.impl.portal.FileChooser=gtk
  '';
}
