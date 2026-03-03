{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home.file = {
    "${config.programs.jjui.configDir}/themes/base24_ayu_dark.toml".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/vic/tinted-jjui/566bd0b376672546b47fb6b8df85924df0d333a2/themes/base24-ayu-dark.toml";
      hash = "sha256-vbpsS11s3nOUmfpxxDLSA2jy3jNqVLqZ157B35/epYY=";
    };
    "${config.programs.jjui.configDir}/themes/base24_ayu_light.toml".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/vic/tinted-jjui/566bd0b376672546b47fb6b8df85924df0d333a2/themes/base24-ayu-light.toml";
      hash = "sha256-IubBkuzAFb2gGMlI0j4hkeTCARqdOSqPUlCeOPtV0Dc=";
    };
  };

  programs = {
    jjui = {
      enable = true;
      settings = {
        ui.theme = {
          dark = "base24_ayu_dark";
          light = "base24_ayu_light";
        };

      };
    };

    jujutsu = {
      enable = true;

      settings = {
        aliases.tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];

        # clone of vscode/vscodium configuration
        merge-tools.cursor = {
          program = "cursor";
          merge-args = [
            "--wait"
            "--merge"
            "$left"
            "$right"
            "$base"
            "$output"
          ];
          conflict-marker-style = "git";
          merge-tool-edits-conflict-markers = true;
          diff-args = [
            "--diff"
            "$left"
            "$right"
            "--wait"
          ];
          diff-invocation-mode = "file-by-file";
          edit-args = [ ];
        };

        templates = {
          log = "builtin_log_oneline";
        };

        ui.default-command = "log";
      };

    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      jujutsu = inputs.jujutsu.packages.${pkgs.system}.jujutsu;
    })
    inputs.jjui.overlays.default
  ];
}
