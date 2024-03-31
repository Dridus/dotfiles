{
  inputs = {
    anyrun = {
      url = "github:Kirottu/anyrun";
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

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ironbar = {
      url = "github:Dridus/ironbar?ref=rmm/clock-label-markup";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "nixpkgs/nixos-unstable";

    xdg-desktop-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland?ref=v1.3.1";
      inputs.hyprland-protocols.follows = "hyprland/hyprland-protocols";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit
      (import ../lib/modules.nix {inherit nixpkgs;})
      partialApplyModule
      publishModules
      ;
    foos = import ../lib/foos.nix {
      inherit (nixpkgs) lib;
      storeRoot = nixpkgs.lib.strings.removeSuffix "/gui" self;
    };
  in {
    homeManagerModules =
      publishModules
      (partialApplyModule {inherit foos inputs;})
      {
        default = [
          ./anyrun
          ./hyprdim
          ./hyprland
          ./hyprpaper
          ./ironbar
          ./misc
          ./obsidian
          ./screenshot
          ./swaync
          ./wezterm
          ./xdg-desktop-portal
          ./xkb
        ];
        _solo = [
          # not default because it needs the appropriate PAM configuration else locking the
          # screen becomes a one-way trip.
          ./lock
        ];
      };
  };
}
