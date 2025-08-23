{
  inputs = {
    dotfiles-lib.url = "github:Dridus/dotfiles-lib";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    nil.url = "github:oxalica/nil";
    nix.url = "github:NixOS/nix/2.27.1";
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
        sourceRootSubdir = "shared";
      };
    in
    {
      homeManagerModules = publishModules (partialApplyModule { inherit foos inputs; }) {
        default = [
          ./bat
          ./direnv
          ./git
          ./home-manager
          ./misc
          ./nix
          ./nushell
          ./zsh
        ];
        _other = [
          ./aerospace
          ./keychain
          ./lsd
          ./man
          ./nvim
          ./rmm
          ./stats
          ./vscode
          ./vscode-server
          ./claude
        ];
      };
    };
}
