{
  inputs = {
    cli = {
      url = "git+file:///home/ross/1st/dotfiles?dir=cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gui = {
      url = "git+file:///home/ross/1st/dotfiles?dir=gui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    local = {
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/illuminance";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations = {
      "ross@illuminance" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};

        modules = [
          {
            dotfiles = {
              homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/illuminance";
              homeFlakeLocalInputs = ["cli" "gui"];
            };
            home.stateVersion = "23.11";
          }

          inputs.cli.homeManagerModules.default
          inputs.cli.homeManagerModules.rmm
          inputs.gui.homeManagerModules.default
          "${inputs.local}/home-local.nix"
        ];
      };
    };
  };
}
