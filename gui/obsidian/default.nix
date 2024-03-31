{pkgs, ...}: let
  obsidianWrapper = pkgs.writeShellApplication {
    name = "obsidian";
    text = ''
      ${pkgs.obsidian}/bin/obsidian --use-angle=opengl "$@"
    '';
    derivationArgs.postCheck = ''
      ln -s ${pkgs.obsidian}/share $out/share
    '';
  };
in {
  home.packages = [obsidianWrapper];
}
