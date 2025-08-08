{ pkgs, ... }:
let
  claude-code-log = pkgs.python3Packages.callPackage ./claude-code-log.nix { };
in
{
  home.packages = [
    pkgs.claude-code
    claude-code-log
  ];
}
