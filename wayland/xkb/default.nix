{foos, pkgs, ...}: {
  xdg.configFile.xkb.source = foos pkgs ./.;
}
