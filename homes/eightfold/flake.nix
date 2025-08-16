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
      url = "path:/home/ross/.config/home-manager";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    nixpkgs.follows = "home-env/nixpkgs";

    home-env.url = "git+file:///home/ross/1st/dridus-com?dir=home";
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    {
      homeConfigurations."ross@eightfold" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = {
          inherit inputs;
        };

        modules =
          let
            shared = inputs.shared.homeManagerModules;
          in
          [
            {
              dotfiles = {
                homeFlake = "git+file:///home/ross/1st/dotfiles?dir=homes/eightfold";
                homeFlakeLocalInputs = [
                  "shared"
                  "local"
                ];
              };

              home.stateVersion = "24.11";
            }
            shared.default
            shared.nvim
            shared.rmm
            shared.vscode-server
            "${inputs.local}/home-local.nix"
          ];
      };
    };
}
