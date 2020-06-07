{ config, pkgs, ... }:

let

  xkbkeymap = ''
    xkb_keymap {
      xkb_keycodes  { include "evdev+aliases(qwerty)"	};
      xkb_types     { include "complete"	};
      xkb_compat    { include "complete"	};
      xkb_symbols   { include "pc+us+inet(evdev)+terminate(ctrl_alt_bksp)+rmm(caps_and_ctrl)"	};
      xkb_geometry  { include "pc(pc104)"	};
    };
  '';

  xkbsymbols = ''
    partial modifier_keys
    xkb_symbols "caps_and_ctrl" {
      replace key <CAPS> { [ Control_L ] };
      replace key <LCTL> { [ Escape ] };
      modifier_map Control { <CAPS> };
    };
  '';

  xkbcompCommand = ''
    #! /bin/sh
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp -I${pkgs.writeTextDir "symbols/rmm" xkbsymbols} ${pkgs.writeText "xkbkeymap" xkbkeymap} $DISPLAY
  '';

  xmonad = pkgs.xmonad-with-packages.override {
    packages = p: with p; [ xmonad-contrib xmonad-extras ];
  };
in

{
  home = {
    file = {
      ".xmonad/xmonad.hs".source = ./xmonad.hs;
      # ".zpreztorc".target = "${pkgs.zsh-prezto}/runcoms/zpreztorc";
      ".zshrc".source = ./zshrc;
    };

    keyboard = null;

    packages = with pkgs; [
      zsh-prezto
      neovim
      google-chrome
      firefox
      file
      exa
      silver-searcher
      feh
      inkscape
      gimp
      glxinfo
      sublime-merge
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

    kitty = {
      enable = true;
      settings = {
        foreground = "#f8f8f2";
        background = "#272822";
        selection_foreground = "#f8f8f2";
        selection_background = "#49483e";
        font_family = "Fira Code Retina";
        font_size = "8";
        visual_bell_duration = "0.05";
        term = "xterm-256color";
      };
    };

    man.enable = true;

    # FIXME neovim?

    # FIXME prezto for zsh
  };

  systemd.user.services = {
    feh-background = {
      Unit = {
        Descriptoin = "Background image";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.feh}/bin/feh --bg-scale ${config.home.homeDirectory}/.config/background.jpg";
      };
    };

    xkbcomp = {
      Unit = {
        Description = "Set up keyboard overrides";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.writeScript "xkbcomp-setup" xkbcompCommand}";
      };
    };
  };

  xdg.configFile = {
    "nvim/init.vim".source = ./nvim/init.vim;
    "polybar/config".source = ./polybar;
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
    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 64;
    };

    windowManager.command = "${xmonad}/bin/xmonad";
  };
}
