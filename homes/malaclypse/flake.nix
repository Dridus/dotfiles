{
  inputs = {
    cli = {
      url = "path:../../cli";
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
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    nixpkgs.url = "nixpkgs/nixos-unstable";
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
        ross = self."ross@malaclypse";
        "ross@malaclypse" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs;
          };

          modules =
            let
              cli = inputs.cli.homeManagerModules;
            in
            [
              {
                disabledModules = [
                  "cli/keychain/default.nix"
                  "cli/man/default.nix"
                ];

                dotfiles = {
                  foosSourceRoot = "/Users/ross/1st/dotfiles";
                  homeFlake = "git+file:///Users/ross/1st/dotfiles?dir=homes/malaclypse";
                  homeFlakeLocalInputs = [ "cli" "local" ];
                };

                home = {
                  homeDirectory = "/Users/ross";
                  stateVersion = "24.11";
                };
              }
              cli.default
              cli.nvim
              cli.vscode
              cli.rmm
              "${inputs.local}/home-local.nix"
            ];
        };
      });
    };
}
