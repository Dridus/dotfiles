{ config, impurity, inputs, lib, pkgs, ... }:
let
  inherit (builtins) readFile;
  inherit (lib) mapAttrsToList;

  hookScripts = mapAttrsToList (name: v: pkgs.writeShellApplication (v // { inherit name; })) {
    rfebar-volume = {
      runtimeInputs = [ pkgs.jq pkgs.pipewire ];
      text = readFile ./rfebar-volume.sh;
    };
    rfebar-swaync = {
      runtimeInputs = [ pkgs.jq pkgs.swaynotificationcenter ];
      text = readFile ./rfebar-swaync.sh;
    };
  };

  runtimeInputs = hookScripts ++ [
    pkgs.hyprland
    pkgs.swaynotificationcenter
  ];
in
{
  assertions = [
    {
      assertion = let
        cfg = config.wayland.windowManager.hyprland;
      in cfg.enable && cfg.systemd.enable;
      message = "gui/ironbar expects hyprland";
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      ironbar = inputs.ironbar.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
  ];

  home.packages = [
    pkgs.fira
    pkgs.font-awesome
    pkgs.ironbar
  ];

  systemd.user.services.ironbar = {
    Unit = {
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = let
      start-ironbar = pkgs.writeShellApplication {
        name = "start-ironbar";
        inherit runtimeInputs;
        text = ''
          export blueberry=${pkgs.blueberry}
          export pavucontrol=${pkgs.pavucontrol}
          "${pkgs.ironbar}/bin/ironbar"
        '';
      };
    in {
      ExecStart = "${start-ironbar}/bin/start-ironbar";
      ExecReload = "${pkgs.ironbar}/bin/ironbar reload";
    };

    Install.WantedBy = [ "hyprland-session.target" ];
  };

  xdg.configFile = {
    "ironbar/config.corn".source = impurity.link ./config.corn;
    "ironbar/style.css".source = impurity.link ./style.css;
  };
}

