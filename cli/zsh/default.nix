{ lib, pkgs, ... }:
let
  inherit (lib) mkBefore mkMerge;
in
{
  home.packages = [ pkgs.perl ];
  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    shellAliases = {
      sysu = "systemctl --user";
      jour = "journalctl --user";
    };

    history = {
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = false;
    };

    initContent = mkMerge [
      (mkBefore ''
        bindkey '^r' history-incremental-search-backward
      '')
      ''
        autoload -U colors && colors
        PROMPT_HOST="$(hostname -s)"
        PROMPT="%{$bg[cyan]$fg[black]%} $PROMPT_HOST %{$bg[black]$fg[yellow]%} %~ ❯ %{$reset_color%}"
        ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true
      ''
    ];

    zplug = {
      enable = true;
      plugins = [
        {
          name = "zdharma-continuum/fast-syntax-highlighting";
          tags = [ "as:plugin" ];
        }
        {
          name = "trystan2k/zsh-tab-title";
          tags = [
            "as:plugin"
            "at:main"
          ];
        }
      ];
    };
  };
}
