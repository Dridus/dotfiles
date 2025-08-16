{
  foos,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.lsd ];
  programs.zsh.shellAliases.ls = "lsd";
  xdg.configFile."lsd/config.yaml".source = foos pkgs ./lsd.yaml;
}
