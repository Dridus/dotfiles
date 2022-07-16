{ config, pkgs, lib, ... }:

let

  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      name = lib.hm.strings.storeFileName (baseNameOf pathStr);
    in
      pkgs.runCommandLocal name {} ''ln -s ${lib.escapeShellArg pathStr} $out'';

  zpreztoContrib = pkgs.fetchFromGitHub {
    owner = "belak";
    repo = "prezto-contrib";
    rev = "17a6e476dbfd304e392243115a40e96332bc30ad";
    sha256 = "090nndj7dnmv213zwksivj19g691sjh4sqzr3ddgmmfdz1n73y0w";
    fetchSubmodules = true;
  };

in

{
  imports = [ ./home-local.nix ];
  manual.manpages.enable = true;

  home = {
    file = {
      ".prezto-contrib".source = zpreztoContrib;
      ".zpreztorc".source = mkOutOfStoreSymlink ./zpreztorc;
      ".zshrc".source = mkOutOfStoreSymlink ./zshrc;
    };

    packages = with pkgs; [
      nushell
      zsh-prezto
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

    git = {
      package = pkgs.git;
      enable = true;
      userName = "Ross MacLeod";
      extraConfig = {
        core.editor = "$EDITOR";
        core.pager = "${pkgs.delta}/bin/delta";
        interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
        add.interactive.useBuiltin = false;
        delta.navigate = true;
        delta.light = false;
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
      };
    };

    jq.enable = true;
    man.enable = true;

    # FIXME prezto for zsh
  };

  xdg.configFile.nvim.source = mkOutOfStoreSymlink ./nvim;
  xdg.dataFile."nvim/site/autoload/plug.vim".source = builtins.fetchurl "https://raw.githubusercontent.com/junegunn/vim-plug/8fdabfba0b5a1b0616977a32d9e04b4b98a6016a/plug.vim";
}
