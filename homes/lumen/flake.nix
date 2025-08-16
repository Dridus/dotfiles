{
  inputs = {
    shared = {
      url = "git+file:///home/ross/1st/dotfiles?dir=shared";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
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

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/lumen";
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    {
      homeConfigurations = nixpkgs.lib.fix (self: {
        ross = self."ross@lumen";
        "ross@lumen" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [
            {
              dotfiles = {
                homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/lumen";
                homeFlakeLocalInputs = [ "shared" ];
              };

              home.stateVersion = "23.11";
            }
            inputs.shared.homeManagerModules.default
            inputs.shared.homeManagerModules.rmm
            inputs.shared.homeManagerModules.keychain
            "${inputs.local}/home-local.nix"
          ];
        };
      });
    };
}
