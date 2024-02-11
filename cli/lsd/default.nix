{
  impurity,
  pkgs,
  ...
}: {
  home = {
    packages = [pkgs.lsd];
    shellAliases.ls = "lsd";
  };
  xdg.configFile."lsd/config.yaml".source = impurity.link ./lsd.yaml;
}
