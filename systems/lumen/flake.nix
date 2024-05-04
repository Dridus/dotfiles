{
  inputs = {
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.follows = "nixos-wsl/nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-wsl,
      ...
    }:
    {
      nixosConfigurations = rec {
        Lumen = lumen;
        lumen = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./config.nix ];
        };
      };
    };
}
