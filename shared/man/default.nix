{pkgs, ...}: {
  home.packages = [pkgs.man-pages];
  manual.manpages.enable = true;
  programs.man.enable = true;
}
