{ foos, pkgs, ... }:
{
  home.packages = [
    pkgs.aerospace
    pkgs.jankyborders
  ];

  xdg.configFile."aerospace/aerospace.toml".source = foos pkgs ./aerospace.toml;
}
