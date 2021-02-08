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
  # manual.manpages.enable = false;

  home = {
    file = {
      ".prezto-contrib".source = zpreztoContrib;
      ".zpreztorc".source = mkOutOfStoreSymlink ./zpreztorc;
      ".zshrc".source = mkOutOfStoreSymlink ./zshrc;
    };

    packages = with pkgs; [
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
      screen
      gnumake
      rustup
      ripgrep
      fd
      fzf
      keychain
      pstree
      direnv
      stdenv.cc 
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
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "Ross MacLeod";
      extraConfig = {
        core.editor = "$EDITOR";
      };
    };

    jq.enable = true;
    man.enable = true;

    # FIXME neovim?

    # FIXME prezto for zsh
  };

  xdg.configFile.nvim.source = mkOutOfStoreSymlink ./nvim;
}
