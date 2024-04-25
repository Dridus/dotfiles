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

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/monsoonite";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations."ross@monsoonite" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};

      modules = [
        {
          dotfiles = {
            homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/monsoonite";
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
