{ pkgs, lib, ... }:
let
  inherit (builtins)
    getFlake
    toString;

  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      name = lib.hm.strings.storeFileName (baseNameOf pathStr);
    in
      pkgs.runCommandLocal name {} ''ln -s ${lib.escapeShellArg pathStr} $out'';

  flake = getFlake (toString ./.);

  pkgsUnstable = import flake.inputs.nixpkgsUnstable {};

  bat-fzf-preview = pkgs.writeShellScriptBin "bat-fzf-preview" ''
    target_line="$1"
    first_window_line="$(($target_line-$FZF_PREVIEW_LINES/2))"
    last_window_line="$(($target_line+$FZF_PREVIEW_LINES))"
    shift
    ${pkgs.bat}/bin/bat \
      --color=always \
      --style=numbers \
      --highlight-line=$target_line \
      --line-range=$(($first_window_line<1?1:$first_window_line)):$(($last_window_line)) \
      "$@"
  '';
in

{
  imports = [ ./home-local.nix ];
  manual.manpages.enable = true;

  home = {
    packages = [
      pkgs.awscli2
      pkgs.bat
      bat-fzf-preview
      pkgs.ctags
      pkgs.delta
      pkgs.direnv
      pkgs.dnsutils
      pkgs.easyrsa
      pkgs.fd
      pkgs.file
      pkgs.fzf
      pkgs.git-filter-repo
      pkgs.git-lfs
      pkgs.gitRepo
      pkgs.glibc.dev
      pkgs.gnumake
      pkgs.helix
      pkgs.keychain
      pkgs.linuxHeaders
      pkgs.lsd
      pkgs.man-pages
      flake.inputs.nil.packages.${builtins.currentSystem}.nil
      pkgs.openssh
      pkgs.openssl
      pkgs.openssl.dev
      pkgs.packer
      pkgs.patchelf
      pkgs.pkg-config
      pkgsUnstable.neovim
      pkgs.pstree
      pkgs.qemu
      pkgs.ripgrep
      pkgs.rsync
      pkgs.screen
      pkgs.stdenv.cc
      pkgs.strace
      pkgs.terraform
      pkgs.unzip
      pkgs.xxd
      pkgs.zip
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FZF_DEFAULT_COMMAND = "fd --type f";
      TERM = "xterm-256color";
    };

    stateVersion = "20.03";
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      package = pkgs.git;
      enable = true;
      userName = "Ross MacLeod";
      extraConfig = {
        core.editor = "$EDITOR";
        core.pager = "${pkgs.delta}/bin/delta";
        interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
        add.interactive.useBuiltin = false;
        include.path = "${builtins.fetchurl "https://raw.githubusercontent.com/dandavison/delta/4c879ac1afca68a30c9a100bea2965b858eb1853/themes.gitconfig"}";
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

    jq.enable = true;
    man.enable = true;

    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      shellAliases = {
        ls = "lsd";
        sysu = "systemctl --user";
        jour = "journalctl --user";
      };
      # enableCompletion = true;
      # enableSyntaxHighlighting = true;
      initExtraFirst = ''
        if [ -e ''${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then source ''${HOME}/.nix-profile/etc/profile.d/nix.sh; fi
        typeset -x BAT_THEME=OneHalfDark
        typeset -x DELTA_SYNTAX_THEME=OneHalfDark
        bindkey '^r' history-incremental-search-backward

        if [ -f "$HOME/.ssh/id_rsa" ]; then
          ${pkgs.keychain}/bin/keychain --nogui $HOME/.ssh/id_rsa
        fi
        if [ -f "$HOME/.ssh/id_ed25519" ]; then
          ${pkgs.keychain}/bin/keychain --nogui $HOME/.ssh/id_ed25519
        fi
        if [ -z "$SSH_AUTH_SOCK" ]; then
          source $HOME/.keychain/$(hostname)-sh
        fi

        # if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        #   source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        # fi
      '';

      initExtra = ''
        # source $HOME/.config/p10k/p10k.zsh

        setopt -o EXTENDED_HISTORY
        setopt -o HIST_IGNORE_DUPS
        setopt -o HIST_IGNORE_SPACE
        setopt +o SHARE_HISTORY

        autoload -U colors && colors
        PROMPT="%{$bg[black]$fg[yellow]%}%~ ❯%{$reset_color%} "
        ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true

        # bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
        # zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
        # zstyle ':autocomplete:*history*:*' insert-unambiguous yes
        # zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
        # zstyle ':autocomplete:*' list-lines 16
      '';

      zplug = {
        enable = true;
        plugins = [
          /* { name = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; } */
          { name = "zdharma-continuum/fast-syntax-highlighting"; tags = ["as:plugin"]; }
          { name = "trystan2k/zsh-tab-title"; tags = ["as:plugin"]; }
        ];
      };
    };
  };

  xdg.configFile = {
    "lsd/config.yaml".source = mkOutOfStoreSymlink ./lsd.yaml;
    # "p10k/p10k.zsh".source = mkOutOfStoreSymlink ./p10k.zsh;
    nvim.source = mkOutOfStoreSymlink ./nvim;
    helix.source = mkOutOfStoreSymlink ./helix;
  };

  xdg.dataFile."nvim/site/autoload/plug.vim".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/vim-plug/8fdabfba0b5a1b0616977a32d9e04b4b98a6016a/plug.vim";
}
