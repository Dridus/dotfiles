# Files Out Of Store. Functionality to link to files directly in the source instead of in the
# nix store, intentionally breaking purity so that home-manager switch isn't required for all
# changes.
#
# Derived from https://github.com/outfoxxed/impurity.nix, but this version is simplified so it
# can be easily used as an partially applied module argument rather than globally in
# _module.args
{
  lib,
  storeRoot,
}: let
  inherit (builtins) getEnv;
  inherit (lib) types;
  inherit (lib.strings) removePrefix;

  foosSourceRoot = getEnv "FOOS_SOURCE_ROOT";

  relativePath = path:
    assert types.path.check path;
      removePrefix (toString storeRoot) (toString path);

  mkOOSLink = pkgs: path: let
    relative = relativePath path;
    full = foosSourceRoot + relative;
  in
    pkgs.runCommand "foos-${relative}" {} "ln -s ${full} $out";
in
  pkgs: path:
    assert types.path.check path;
      if foosSourceRoot == ""
      then path
      else mkOOSLink pkgs path
