{
  inputs = {
    nil.url = "github:oxalica/nil";

    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit
      (import ../lib/modules.nix {inherit nixpkgs;})
      partialApplyModule
      publishModules
      ;
    foos = import ../lib/foos.nix {
      inherit (nixpkgs) lib;
      storeRoot = nixpkgs.lib.strings.removeSuffix "/cli" self;
    };
  in {
    homeManagerModules =
      publishModules
      (partialApplyModule {inherit foos inputs;}) {
        default = [
          ./bat
          ./direnv
          ./git
          ./home-manager
          ./keychain
          ./lsd
          ./man
          ./misc
          ./nvim
          ./zsh
        ];
        _rmm = [
          ./rmm
        ];
      };
  };
}
