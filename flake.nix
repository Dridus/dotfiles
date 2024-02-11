{
  inputs = {
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.34.0";
      inputs.hyprland.follows = "hyprland";
    };

    hyprfocus = {
      url = "github:VortexCoyote/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.34.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpaper = {
      url = "github:hyprwm/Hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impurity.url = "github:outfoxxed/impurity.nix";

    ironbar = {
      url = "github:Dridus/ironbar?ref=rmm/clock-label-markup";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    nixos-apple-silicon.follows = "system-config/nixos-apple-silicon";

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "/etc/nixos/system-config";

    xdg-desktop-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland?ref=v1.3.1";
      inputs.hyprland-protocols.follows = "hyprland/hyprland-protocols";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    home-manager,
    impurity,
    nixpkgs,
    ...
  } @ inputs: {
    homeConfigurations = {
      "ross@Lumen" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};

        modules = [
          {
            home.stateVersion = "23.11";
          }
          impurity.nixosModules.default
          ./cli
          ./home-local.nix
        ];
      };

      "ross@radiance" = let
        baseConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = {inherit inputs;};

          modules = [
            {
              home.stateVersion = "23.11";

              impurity = {
                enable = true;
                configRoot = self;
              };

              nixpkgs.overlays = [
                inputs.nixos-apple-silicon.overlays.default
              ];
            }
            impurity.nixosModules.default
            ./cli
            ./gui
            ./home-local.nix
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
