{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    file = {
      "${config.programs.jjui.configDir}/themes/base24_ayu_dark.toml".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/vic/tinted-jjui/566bd0b376672546b47fb6b8df85924df0d333a2/themes/base24-ayu-dark.toml";
        hash = "sha256-vbpsS11s3nOUmfpxxDLSA2jy3jNqVLqZ157B35/epYY=";
      };
      "${config.programs.jjui.configDir}/themes/base24_ayu_light.toml".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/vic/tinted-jjui/566bd0b376672546b47fb6b8df85924df0d333a2/themes/base24-ayu-light.toml";
        hash = "sha256-IubBkuzAFb2gGMlI0j4hkeTCARqdOSqPUlCeOPtV0Dc=";
      };
    };
    packages = [
      inputs.jj-spr.packages.${pkgs.system}.default
    ];
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
        aliases = {
          push = [
            "git"
            "push"
            "--bookmark"
            "ross/*"
          ];
          # https://isaaccorbrey.com/notes/jujutsu-megamerges-for-fun-and-profit
          restack = [
            "rebase"
            "--onto"
            "trunk()"
            "--source"
            "roots(trunk()..) & mutable()"
            "--simplify-parents"
          ];
          spr = [
            "util"
            "exec"
            "--"
            "jj-spr"
          ];
          stack = [
            "rebase"
            "--after"
            "trunk()"
            "--before"
            "closest_merge(@)"
          ];
        };

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
          op_log = "builtin_op_log_oneline";
        };
        template-aliases = {
          "format_duration(dur)" = ''
            dur
              .replace("less than a microsecond", "now")
              .replace(regex:"\\sdays?", "d")
              .replace(regex:"\\shours?", "h")
              .replace(regex:"\\sminutes?", "m")
              .replace(regex:"\\sseconds?", "s")
              .replace(regex:"\\smilliseconds?", "ms")
              .replace(regex:"\\smicroseconds?", "µs")
              .replace(regex:"\\snanoseconds?", "ns")
          '';
          "format_time_range(time_range)" = ''
            format_timestamp(time_range.end())
              ++ label("time", ", ")
              ++ format_duration(time_range.duration())
          '';
          "format_operation_oneline(op)" = ''
            separate(" ",
              format_short_operation_id(op.id()),
              op.user().replace(regex:"@.*", ""),
              format_time_range(op.time()),
              op.description().first_line(),
              op.tags(),
            ) ++ "\n"
          '';
        };

        ui.default-command = "log";
      };

    };

    nushell = {
      extraConfig = ''
        use ${inputs.jj-nushell-dynamic-completions}/jj-completions.nu *
        $env.config.completions.external = {
          enable: true
          max_results: 200
          completer: (jj-external-completer)
        }
      '';
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      jujutsu = inputs.jujutsu.packages.${pkgs.system}.jujutsu;
    })
    inputs.jjui.overlays.default
  ];
}
