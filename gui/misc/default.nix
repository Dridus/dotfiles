{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Teal-Dark";
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


