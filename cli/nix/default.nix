{ inputs, pkgs, ... }: {
  nixpkgs.overlays = [ (final: prev: { nix = inputs.nix.packages.${pkgs.system}.nix; }) ];
}
