{
  inputs = {
    shared = {
      url = "path:../../shared";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    local = {
      url = "path:/Users/ross/.config/home-manager";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil.url = "github:oxalica/nil";
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
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
        ross = self."ross@enodia";
        "ross@Enodia" = self."ross@enodia";
        "ross@enodia" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs;
          };

          modules =
            let
              shared = inputs.shared.homeManagerModules;
              enodia =
                { pkgs, ... }:
                {
                  disabledModules = [
                    "shared/man/default.nix"
                  ];

                  dotfiles = {
                    foosSourceRoot = "/Users/ross/1st/dotfiles";
                    homeFlake = "git+file:///Users/ross/1st/dotfiles?dir=homes/enodia";
                    homeFlakeLocalInputs = [ "shared" ];
                  };

                  home = {
                    homeDirectory = "/Users/ross";
                    packages = [
                      pkgs.qalculate-gtk
                    ];
                    stateVersion = "23.11";
                  };
                };
            in
            [
              enodia
              shared.aerospace
              shared.default
              shared.nushell
              shared.nvim
              shared.vscode
              shared.claude
              shared.rmm
              "${inputs.local}/home-local.nix"
            ];
        };
      });
    };
}
