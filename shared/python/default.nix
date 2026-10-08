{ pkgs, ... }: {
  home.packages = [ (pkgs.python3.withPackages (_: [ ])) ];
}
