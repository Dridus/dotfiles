{ config, pkgs, lib, ... }:

let

  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      name = lib.hm.strings.storeFileName (baseNameOf pathStr);
    in
      pkgs.runCommandLocal name {} ''ln -s ${lib.escapeShellArg pathStr} $out'';

in

{
  imports = [ ./home-local.nix ];
  manual.manpages.enable = true;

  home = {
    packages = with pkgs; [
      neovim
      file
      zip
      unzip
      packer
      terraform
      easyrsa
      git-lfs
      patchelf
      ctags
      openssl
      openssl.dev
      screen
      gnumake
      ripgrep
      fd
      fzf
      keychain
      pstree
      direnv
      stdenv.cc 
      glibc.dev
      linuxHeaders
      man-pages
      rsync
      pkg-config
      qemu
      # helix
      bat
      (writeShellScriptBin "bat-fzf-preview" ''
        target_line="$1"
        first_window_line="$(($target_line-$FZF_PREVIEW_LINES/2))"
        last_window_line="$(($target_line+$FZF_PREVIEW_LINES))"
        shift
        ${bat}/bin/bat --color=always --style=numbers --highlight-line=$target_line --line-range=$(($first_window_line<1?1:$first_window_line)):$(($last_window_line)) "$@"
      '')
      delta
      lsd
      strace
      dnsutils
      openssh
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
      enableCompletion = true;
      enableSyntaxHighlighting = true;
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
        source $HOME/.keychain/$(hostname)-sh

        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      initExtra = ''
        source $HOME/.config/p10k/p10k.zsh

        setopt -o EXTENDED_HISTORY
        setopt -o HIST_IGNORE_DUPS
        setopt -o HIST_IGNORE_SPACE
        setopt +o SHARE_HISTORY

        bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
        zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
        zstyle ':autocomplete:*history*:*' insert-unambiguous yes
        zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
        zstyle ':autocomplete:*' list-lines 16
      '';

      zplug = {
        enable = true;
        plugins = [
          { name = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; }
          { name = "marlonrichert/zsh-autocomplete"; tags = ["as:plugin"]; }
          { name = "trystan2k/zsh-tab-title"; tags = ["as:plugin"]; }
        ];
      };
    };
  };

  xdg.configFile = {
    "lsd/config.yaml".source = mkOutOfStoreSymlink ./lsd.yaml;
    "p10k/p10k.zsh".source = mkOutOfStoreSymlink ./p10k.zsh;
    nvim.source = mkOutOfStoreSymlink ./nvim;
  };

  xdg.dataFile."nvim/site/autoload/plug.vim".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/vim-plug/8fdabfba0b5a1b0616977a32d9e04b4b98a6016a/plug.vim";
}
