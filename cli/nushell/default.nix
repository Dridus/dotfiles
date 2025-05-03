{
  foos,
  pkgs,
  ...
}:
let
  nu_scripts = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "9560df937090b640ed04aa270641a77b8d5f991c";
    hash = "sha256-Zw6eIo9BTn6/4qd03Jca3Kp3KZwHJEwEoUcnuS3Z9NM=";
  };
in
{
  programs.nushell = {
    enable = true;
    extraConfig = ''
      use ${nu_scripts}/themes/nu-themes/vs-code-dark-plus.nu
      source ${foos pkgs ./config.nu}
    '';
    plugins = [
      pkgs.nushellPlugins.polars
      pkgs.nushellPlugins.query
    ];
  };
}
