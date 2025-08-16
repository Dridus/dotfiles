{
  config,
  foos,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    listToAttrs
    ;

  system = pkgs.stdenv.hostPlatform.system;
  anyrunPackages = inputs.anyrun.packages.${system};
  anyrun = anyrunPackages.default;
in {
  assertions = [
    {
      assertion = let
        cfg = config.wayland.windowManager.hyprland;
      in
        cfg.enable && cfg.systemd.enable;
      message = "wayland/anyrun expects hyprland";
    }
  ];

  home.packages = [
    anyrun
  ];

  wayland.windowManager.hyprland.settings."$menu" = "${anyrun}/bin/anyrun";

  xdg.configFile =
    {
      "anyrun/applications.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 5,
          terminal: Some("${pkgs.wezterm}/bin/wezterm"),
        )
      '';
      "anyrun/config.ron".source = foos pkgs ./config.ron;
      "anyrun/dictionary.ron".text = ''
        Config(
          prefix: ":def",
          max_entries: 10,
        )
      '';
      "anyrun/style.css".source = foos pkgs ./style.css;
      "anyrun/symbols.ron".text = ''
        Config(
          prefix: ":sym",
          symbols: {},
          max_entries: 10,
        )
      '';
    }
    // listToAttrs (map (pkg: {
        name = "anyrun/plugins/lib${pkg.pname}.so";
        value = {source = "${pkg}/lib/lib${pkg.pname}.so";};
      }) [
        anyrunPackages.applications
        anyrunPackages.dictionary
        anyrunPackages.rink
        anyrunPackages.shell
        anyrunPackages.symbols
        anyrunPackages.translate
      ]);
}
