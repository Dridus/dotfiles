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

    impurity.url = "github:outfoxxed/impurity.nix";

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
    impurity,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations = {
      "ross@illuminance" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs;};

          modules = [
            {
              dotfiles.homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/illuminance";

              home.stateVersion = "23.11";

              impurity = {
                enable = true;
                configRoot = nixpkgs.lib.strings.removeSuffix "/homes/illuminance" self;
              };
            }
            impurity.nixosModules.default
            inputs.cli.homeManagerModules.default
            inputs.gui.homeManagerModules.default
            "${inputs.local}/home-local.nix"
          ];
        };
    };
  };
}
