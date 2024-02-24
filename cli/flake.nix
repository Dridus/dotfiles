{
  inputs = {
    nil.url = "github:oxalica/nil";

    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit
      (import ../lib/modules.nix {inherit nixpkgs;})
      partialApplyModule
      publishModules
      ;
  in {
    homeManagerModules =
      publishModules
      (partialApplyModule {inherit inputs;})
      [
        ./bat
        ./direnv
        ./git
        ./keychain
        ./lsd
        ./man
        ./misc
        ./nvim
        ./zsh
      ];
  };
}
