{
  inputs = {
    cli = {
      url = "git+file:///home/ross/1st/dotfiles?dir=cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    local = {
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/lightbreaker";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations."ross@lightbreaker" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-linux;
      extraSpecialArgs = {inherit inputs;};

      modules = [
        {
          disabledModules = [ "cli/keychain/default.nix" ];

          dotfiles = {
            homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/lightbreaker";
            homeFlakeLocalInputs = ["cli"];
          };

          home.stateVersion = "23.11";
        }
        inputs.cli.homeManagerModules.default
        inputs.cli.homeManagerModules.rmm
        "${inputs.local}/home-local.nix"
      ];
    };
  };
}
