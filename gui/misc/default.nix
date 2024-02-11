{pkgs, ...}: {
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    theme = {
      package = pkgs.pantheon.elementary-gtk-theme;
      name = "io.elementary.stylesheet.strawberry";
    };
  };

  home.packages = [
    pkgs.firefox
    pkgs.glxinfo
    pkgs.qt6ct
    pkgs.shutter
    # pkgs.slack # no arm64 linux package lolsob
    pkgs.sublime-merge
  ];
}
