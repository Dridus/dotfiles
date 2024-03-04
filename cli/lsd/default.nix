{
  foos,
  pkgs,
  ...
}: {
  home = {
    packages = [pkgs.lsd];
    shellAliases.ls = "lsd";
  };
  xdg.configFile."lsd/config.yaml".source = foos pkgs ./lsd.yaml;
}
