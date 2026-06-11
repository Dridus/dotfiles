{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.claude-code-nix.packages.${pkgs.system}.default
  ];
}
