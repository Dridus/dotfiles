{
  config,
  impurity,
  pkgs,
  ...
}: {
  assertions = [
    {
      assertion = config.programs.zsh.enable;
      message = "gui/wezterm expects zsh";
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      wezterm = prev.wezterm.overrideAttrs rec {
        version = "20240128-202157-1e552d76";
        src = pkgs.fetchFromGitHub {
          owner = "wez";
          repo = "wezterm";
          rev = version;
          fetchSubmodules = true;
          hash = "sha256-ZmsWTtxW6/Sx2zvuX2aZSiFxoD4g29brby2cd2DCq0o=";
        };
        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = ./wezterm-20240128-202157-1e552d76-Cargo.lock;
          outputHashes = {
            "xcb-imdkit-0.3.0" = "sha256-fTpJ6uNhjmCWv7dZqVgYuS2Uic36XNYTbqlaly5QBjI=";
          };
        };
      };
    })
  ];

  home.packages = [
    pkgs.wezterm
    pkgs.nerdfonts
  ];

  programs.zsh.initExtra = ''
    source "${pkgs.wezterm}/etc/profile.d/wezterm.sh"
  '';

  wayland.windowManager.hyprland.settings."$terminal" = "${pkgs.wezterm}/bin/wezterm start --always-new-process";

  xdg.configFile."wezterm/wezterm.lua".source = impurity.link ./wezterm.lua;
}
