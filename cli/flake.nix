{
  inputs = {
    dotfiles-lib.url = "github:Dridus/dotfiles-lib";
    nil.url = "github:oxalica/nil";
    nixos-vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-nixfmt.url = "nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (inputs.dotfiles-lib.lib) partialApplyModule publishModules;
      foos = inputs.dotfiles-lib.lib.foos {
        storeRoot = self;
        sourceRootSubdir = "cli";
      };
    in
    {
      homeManagerModules = publishModules (partialApplyModule { inherit foos inputs; }) {
        default = [
          ./bat
          ./direnv
          ./git
          ./home-manager
          ./lsd
          ./man
          ./misc
          ./zsh
        ];
        _other = [
          ./keychain
          ./nvim
          ./rmm
          ./vscode
          ./vscode-server
        ];
      };
    };
}
