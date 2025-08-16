{
  foos,
  pkgs,
  ...
}:
let
  nu_scripts = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "ec945380be3981522f9bb55e764a5254a908e652";
    hash = "sha256-0fw0fJSlUnT5vbBHDubqLrk3F+OU7CE15vIeU295C4w=";
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
