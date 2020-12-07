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
  imports = [
    /home/ross/vital/vital-nix/user/p53.nix
    /home/ross/vital/vital-nix/user/software-workstation.nix
    /home/ross/vital/vital-nix/packages/overlays.nix
  ];

  nixpkgs.overlays = [
    (self: super: {
      # openmodelica = self.callPackage ./openmodelica.nix {};
      # zoom-us = self.libsForQt5.callPackage ./zoom-us.nix {};
    })
  ];

  manual.manpages.enable = false;

  home = {
    file = {
      ".prezto-contrib".source = zpreztoContrib;
      ".zpreztorc".source = mkOutOfStoreSymlink ./zpreztorc;
      ".zshrc".source = mkOutOfStoreSymlink ./zshrc;
    };

    packages = with pkgs; [
      zsh-prezto        # shellz
      neovim            # edit those texts
      google-chrome     # faster creepier browser
      firefox           # slower browser
      file              #
      exa               # ls
      silver-searcher   # like grep but greppier
      inkscape          # vector image
      gimp              # raster image
      glxinfo           # dunno, check out some GPU stuff
      xorg.xwininfo     # dump them windows
      xorg.xev          # dump them events
      xorg.xcompmgr     # window compositing
      sublime-merge     # git
      fira              # variable width font
      fira-code         # fixed width font
      open-sans         # dunno why I have this
      font-awesome      # iconz
      virt-manager      # VMs
      remmina           # remote desktop
      zip               # put things in the box
      unzip             # take things out of the box
      kitty             # terminal
      adapta-kde-theme  # good lookin kde that scales?
      adapta-gtk-theme  # good lookin gtk that scales
      arc-icon-theme    # some icons
      evince            # pdf viewer
      vlc               # media player
      _1password        # CLI secrets
      v4l_utils         # Tweak the camera
      packer            # prepare and...
      terraform         # Go to ~Mars~ the cloud!
      easyrsa           # Manage PKI
      gnomeExtensions.appindicator   # show systray stuff in the top bar
      gnomeExtensions.system-monitor # graphs and statzz
      wineWowPackages.full           # wine works surprisingly well!
      (winetricks.override { wine = wineWowPackages.full; }) # winetricks is basically mandatory
      git-lfs                        # big stuff!
      shutter           # fancy screenshots... that I never use?
      wireshark         # packets!
      libreoffice       # spreadsheets, basically
      # openmodelica      # OMG OMC
      # octaveFull        # desktop calculator... or something more??
      guvcview          # webcam stuff
      slack
      zoom-us           # business business business. is this working?
      eagle
      kicad-with-packages3d
      patchelf
      ovftool
      ctags
      openssl
      speedcrunch
      prusa-slicer
      bmap-tools
      screen
      gnumake
      rustup
      emacs27
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
    "autostart/org.gnome.SettingsDaemon.Keyboard.desktop".source = mkOutOfStoreSymlink ./org.gnome.SettingsDaemon.Keyboard.desktop;
    "kitty/kitty.conf".source = mkOutOfStoreSymlink ./kitty.conf;
# "nvim/init.vim".source = mkOutOfStoreSymlink ./nvim/init.vim;
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

    windowManager.command = "${pkgs.gnome3.gnome-session}/bin/gnome-session";
  };
}
