{ inputs, pkgs, ... }:
let
  claude-code-log = pkgs.python3Packages.callPackage ./claude-code-log.nix { };
in
{
  home.packages = [
    inputs.claude-code-nix.packages.${pkgs.system}.default
    claude-code-log
  ];
}
