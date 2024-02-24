{
  inputs = {
    cli = {
      url = "git+file:///home/ross/1st/dotfiles?dir=cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gui = {
      url = "git+file:///home/ross/1st/dotfiles?dir=gui";
      inputs = {
        # nested input overrides don't seem to work at least in v2.18.1, resulting in metastable
        # inputs and incorrect resolution. but, floating the inputs up and following them works
        hy3.follows = "hy3";
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.34.0";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.34.0";
    };

    impurity.url = "github:outfoxxed/impurity.nix";

    local = {
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    nixos-apple-silicon.follows = "system-config/nixos-apple-silicon";

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/radiance";
  };

  outputs = {
    self,
    home-manager,
    impurity,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations = {
      "ross@radiance" = let
        baseConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = {inherit inputs;};

          modules = [
            {
              dotfiles.homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/radiance";

              home.stateVersion = "23.11";

              impurity = {
                enable = true;
                configRoot = nixpkgs.lib.strings.removeSuffix "/homes/radiance" self;
              };

              nixpkgs.overlays = [
                inputs.nixos-apple-silicon.overlays.default
              ];
            }
            impurity.nixosModules.default

            inputs.cli.homeManagerModules.default
            inputs.gui.homeManagerModules.default

            "${inputs.local}/home-local.nix"
          ];
        };
        inherit (baseConfig) pkgs;
      in
        baseConfig
        // {
          activationPackage = pkgs.replaceDependency {
            oldDependency = pkgs.mesa;
            newDependency = pkgs.mesa-asahi-edge;
            drv = baseConfig.activationPackage;
          };
        };
    };
  };
}
