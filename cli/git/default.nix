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
    userName = "Ross MacLeod";
    extraConfig = {
      core.editor = "$EDITOR";
      core.pager = "${pkgs.delta}/bin/delta";
      interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
      add.interactive.useBuiltin = false;
      include.path = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/dandavison/delta/4c879ac1afca68a30c9a100bea2965b858eb1853/themes.gitconfig";
        sha256 = "d+g4xcnMicguU9LhsdeZUrB8r6PKT0E79iAo7lLRuxI=";
      }}";
      delta = {
        features = "chameleon";
        side-by-side = false;
        navigate = true;
        light = false;
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };
}
