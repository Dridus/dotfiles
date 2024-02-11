{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      inherit (inputs.nil.packages.${pkgs.stdenv.hostPlatform.system}) nil;
    })
  ];
}
