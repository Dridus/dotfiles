{
  inputs = {
    dotfiles-lib.url = "github:Dridus/dotfiles-lib";
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.27";
    forge = {
      url = "github:antinomyhq/forgecode?ref=v2.9.9";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager?ref=master";
    jjui.url = "github:idursun/jjui?ref=v0.10.2";
    jujutsu.url = "github:jj-vcs/jj?ref=v0.39.0";
    nil.url = "github:oxalica/nil";
    nix.url = "github:NixOS/nix/2.32.3";
    nixos-vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
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
          ./jj
          ./misc
          ./nix
          ./nushell
          ./zsh
        ];
        _other = [
          ./aerospace
          ./claude
          ./forge
          ./keychain
          ./lsd
          ./man
          ./nvim
          ./rmm
          ./stats
          ./vscode
          ./vscode-server
        ];
      };
    };
}
