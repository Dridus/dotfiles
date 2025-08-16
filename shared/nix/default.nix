{ inputs, pkgs, ... }:
{
  home.packages = [ pkgs.nix ];
  nixpkgs.overlays = [
    (final: prev: {
      nix = inputs.nix.packages.${pkgs.system}.nix;
      nixos-option = pkgs.writeShellScriptBin "nixos-option" ''
        echo disabled due to conflict between nixpkgs 24.11 and nix 2.27.1
      '';
    })
  ];
}
