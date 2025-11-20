{pkgs, ...}: {
  home = {
    packages = [
      pkgs.delta
      pkgs.git-filter-repo
      pkgs.git-lfs
      pkgs.gitRepo
    ];

    sessionVariables.DELTA_SYNTAX_THEME = "OneHalfDark";
  };

  programs.git = {
    package = pkgs.git;
    enable = true;
    settings = {
      add.interactive.useBuiltin = false;
      branch.autoSetupMerge = "simple";
      core.editor = "$EDITOR";
      core.pager = "${pkgs.delta}/bin/delta";
      delta = {
        features = "chameleon";
        side-by-side = false;
        navigate = true;
        light = false;
      };
      diff.colorMoved = "default";
      include.path = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/dandavison/delta/4c879ac1afca68a30c9a100bea2965b858eb1853/themes.gitconfig";
        sha256 = "d+g4xcnMicguU9LhsdeZUrB8r6PKT0E79iAo7lLRuxI=";
      }}";
      interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
      merge.conflictstyle = "diff3";
    };
  };
}
