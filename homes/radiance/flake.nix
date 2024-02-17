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

    local = {
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    nil.url = "github:oxalica/nil";

    nixos-apple-silicon.follows = "system-config/nixos-apple-silicon";

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/radiance";

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
            ../../cli
            ../../gui
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
