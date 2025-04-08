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
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    nixpkgs.follows = "system-config/nixpkgs";

    system-config.url = "path:../../systems/lightbreaker";
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    {
      homeConfigurations."ross@lightbreaker" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = {
          inherit inputs;
        };

        modules =
          let
            cli = inputs.cli.homeManagerModules;
          in
          [
            {
              disabledModules = [ "cli/keychain/default.nix" ];

              dotfiles = {
                homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/lightbreaker";
                homeFlakeLocalInputs = [ "cli" "local" ];
              };

              home.stateVersion = "23.11";
            }
            cli.default
            cli.nvim
            cli.rmm
            cli.vscode-server
            "${inputs.local}/home-local.nix"
          ];
      };
    };
}
