{ lib, ... }:
{
  dotfiles = {
    foosSourceRoot = lib.mkDefault "/home/ross/1st/dotfiles";
  };
  home = {
    homeDirectory = lib.mkDefault "/home/ross";
    username = lib.mkDefault "ross";
  };
  programs.git.settings.user.name = "Ross MacLeod";
}
