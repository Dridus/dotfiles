{
  foos,
  pkgs,
  ...
}:
let
  nu_scripts = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "b09b60cc434bb9be05ce2bbb6dc299760d13b18b";
    hash = "sha256-Vh2yuIMvYiYdCYWqFRx7G24hWrQ5iJr1byOV/pIkFyI=";
  };
in
{
  programs.nushell = {
    enable = true;
    extraConfig = ''
      use std/dirs
      use ${nu_scripts}/custom-completions/cargo/cargo-completions.nu *
      use ${nu_scripts}/custom-completions/git/git-completions.nu *
      use ${nu_scripts}/custom-completions/just/just-completions.nu *
      use ${nu_scripts}/custom-completions/nix/nix-completions.nu *
      use ${nu_scripts}/themes/nu-themes/vs-code-dark-plus.nu
      source ${foos pkgs ./config.nu}
      source ${foos pkgs ./utils.nu}
    '';
    plugins = [
      pkgs.nushellPlugins.polars
      pkgs.nushellPlugins.query
    ];
  };
}
