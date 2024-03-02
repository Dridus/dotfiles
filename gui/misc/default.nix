{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) optionals;

  system = pkgs.hostPlatform.system;
in {
  gtk = let
    commonConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-font-name = "Fira Sans 11";
    };
  in {
    enable = true;
    gtk3.extraConfig = commonConfig;
    gtk4.extraConfig = commonConfig;
    iconTheme = {
      package = pkgs.pantheon.elementary-icon-theme;
      name = "io.elementary.icons";
    };
    theme = {
      package = pkgs.pantheon.elementary-gtk-theme;
      name = "io.elementary.stylesheet.strawberry";
    };
  };

  home.packages =
    [
      pkgs.firefox
      pkgs.hyprpicker
      pkgs.nwg-look
      pkgs.pantheon.elementary-iconbrowser
      pkgs.qt6ct
      pkgs.sublime-merge
      pkgs.wev
      pkgs.wl-clipboard
      pkgs.wlr-randr
    ]
    ++ optionals (pkgs.hostPlatform.system == "x86_64-linux") [
      pkgs.slack # no arm64 linux package lolsob
    ];

  nixpkgs.overlays = [
    (final: prev: {
      hyprpicker = inputs.hyprpicker.packages.${system}.default;
    })
  ];
}
