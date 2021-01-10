{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome     # faster creepier browser
    firefox           # slower browser
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
    kitty             # terminal
    adapta-kde-theme  # good lookin kde that scales?
    adapta-gtk-theme  # good lookin gtk that scales
    arc-icon-theme    # some icons
    evince            # pdf viewer
    vlc               # media player
    v4l_utils         # Tweak the camera
    gnomeExtensions.appindicator   # show systray stuff in the top bar
    gnomeExtensions.system-monitor # graphs and statzz
    wineWowPackages.full           # wine works surprisingly well!
    (winetricks.override { wine = wineWowPackages.full; }) # winetricks is basically mandatory
    # openmodelica      # OMG OMC
    # octaveFull        # desktop calculator... or something more??
    shutter           # fancy screenshots... that I never use?
    wireshark         # packets!
    libreoffice       # spreadsheets, basically
    guvcview          # webcam stuff
    slack
    zoom-us           # business business business. is this working?
    eagle
    kicad-with-packages3d
    ovftool
    speedcrunch
    prusa-slicer
    emacs27
  ];

  xsession = {
    enable = true;

    windowManager.command = "${pkgs.gnome3.gnome-session}/bin/gnome-session";
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
}
