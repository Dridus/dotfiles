{ inputs, pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;

    # clone of vscode/vscodium configuration
    settings.merge-tools.cursor = {
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
  };
  nixpkgs.overlays = [
    (final: prev: {
      jujutsu = inputs.jujutsu.packages.${pkgs.system}.jujutsu;
    })
  ];
}
