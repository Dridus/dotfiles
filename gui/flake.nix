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

  outputs = {nixpkgs, ...} @ inputs: let
    inherit
      (import ../lib/modules.nix {inherit nixpkgs;})
      partialApplyModule
      publishModules
      ;
  in {
    homeManagerModules =
      publishModules
      (partialApplyModule {inherit inputs;})
      [
        ./anyrun
        ./hyprdim
        ./hyprland
        ./hyprpaper
        ./ironbar
        ./misc
        ./screenshot
        ./swaync
        ./wezterm
        ./xdg-desktop-portal
        ./xkb
      ];
  };
}
