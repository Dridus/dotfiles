{ config, pkgs, lib, ... }:

let

  xmonad = pkgs.xmonad-with-packages.override {
    packages = p: with p; [ xmonad-contrib xmonad-extras ];
  };

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
  imports = [
    /home/ross/vital/vital-nix/user/feh-background.nix
    /home/ross/vital/vital-nix/user/xkb-caps-and-ctrl.nix
    /home/ross/vital/vital-nix/user/p53.nix
    /home/ross/vital/vital-nix/user/software-workstation.nix
  ];

  home = {
    file = {
      ".xmonad/xmonad.hs".source = mkOutOfStoreSymlink ./xmonad.hs;
      ".prezto-contrib".source = zpreztoContrib;
      ".zpreztorc".source = mkOutOfStoreSymlink ./zpreztorc;
      ".zshrc".source = mkOutOfStoreSymlink ./zshrc;
    };

    packages = with pkgs; [
      zsh-prezto
      neovim
      google-chrome
      firefox
      file
      exa
      silver-searcher
      inkscape
      gimp
      glxinfo
      sublime-merge
      rofi
      fira
      fira-code
      open-sans
      font-awesome
      virt-manager
      remmina
      zip
      unzip
      kitty
      speedcrunch
      adapta-kde-theme
      adapta-gtk-theme
      arc-icon-theme
      evince
    ];

    sessionVariables = {
      EDITOR = "nvim";
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
      userEmail = "ross@vitalbio.com";
      extraConfig = {
        core.editor = "$EDITOR";
      };
    };

    jq.enable = true;
    man.enable = true;

    # FIXME neovim?

    # FIXME prezto for zsh
  };

  xdg.configFile = {
    "kitty/kitty.conf".source = mkOutOfStoreSymlink ./kitty.conf;
    "nvim/init.vim".source = mkOutOfStoreSymlink ./nvim/init.vim;
    "polybar/config".source = mkOutOfStoreSymlink ./polybar;
    "rofi/config.rasi".source = mkOutOfStoreSymlink ./rofi.rasi;
  };

  xresources.properties = {
    # special
    "*.foreground"  = "#d1d1d1";
    # *.background:   #221e2d
    "*.cursorColor" = "#d1d1d1";

    # black
    "*.color0"   = "#272822";
    "*.color8"   = "#75715e";

    # red
    "*.color1"   = "#f92672";
    "*.color9"   = "#f92672";

    # green
    "*.color2"   = "#a6e22e";
    "*.color10"  = "#a6e22e";

    # yellow
    "*.color3"   = "#f4bf75";
    "*.color11"  = "#f4bf75";

    # blue
    "*.color4"   = "#66d9ef";
    "*.color12"  = "#66d9ef";

    # magenta
    "*.color5"   = "#ae81ff";
    "*.color13"  = "#ae81ff";

    # cyan
    "*.color6"   = "#a1efe4";
    "*.color14"  = "#a1efe4";

    # white
    "*.color7"   = "#f8f8f2";
    "*.color15"  = "#f9f8f5";

    "Xft.dpi"       = 192;
    "Xft.antialias" = true;
    "Xft.hinting"   = true;
    "Xft.rgba"      = "rgb";
    "Xft.autohint"  = false;
    "Xft.hintstyle" = "hintslight";
    "Xft.lcdfilter" = "lcddefault";

    "*termname"           = "xterm-256color";
    "dmenu.selforeground" = "#FFFFFF";
    "dmenu.background"    = "#000000";
    "dmenu.selbackground" = "#0C73C2";
    "dmenu.foreground"    = "#A0A0A0";
  };

  xsession = {
    enable = true;

    windowManager.command = "${xmonad}/bin/xmonad";
  };
}