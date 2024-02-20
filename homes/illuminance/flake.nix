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
      url = "github:Dridus/hy3?ref=rmm/special-workspace-support";
      inputs.hyprland.follows = "hyprland";
    };

    hyprfocus = {
      url = "github:VortexCoyote/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.35.0";
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

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "git+file:///home/ross/1st/dotfiles?dir=systems/illuminance";

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
            ../../cli
            ../../gui
            "${inputs.local}/home-local.nix"
          ];
        };
    };
  };
}
