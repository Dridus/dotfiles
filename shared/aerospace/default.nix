{ foos, pkgs, ... }:
{
  home.packages = [
    pkgs.aerospace
  ];

  xdg.configFile."aerospace/aerospace.toml".source = foos pkgs ./aerospace.toml;
}
