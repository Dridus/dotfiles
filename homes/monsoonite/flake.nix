{
  inputs = {
    local = {
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impurity.url = "github:outfoxxed/impurity.nix";

    nil.url = "github:oxalica/nil";

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "/etc/nixos/system-config";
  };

  outputs = {
    self,
    home-manager,
    impurity,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations."ross@monsoonite" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};

      modules = [
        {
          dotfiles.homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/monsoonite";
          home.stateVersion = "23.11";
          impurity = {
            enable = true;
            configRoot = nixpkgs.lib.strings.removeSuffix "/homes/monsoonite" self;
          };
        }
        impurity.nixosModules.default
        ../../cli
        "${inputs.local}/home-local.nix"
      ];
    };
  };
}
