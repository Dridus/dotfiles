{
  inputs = {
    local = {
      url = "path:/etc/nixos/system-config-local";
      flake = false;
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.follows = "nixos-wsl/nixpkgs";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-wsl,
    ...
  }: rec {
    nixosConfigurations.Monsoon = nixosConfigurations.monsoonite;
    nixosConfigurations.monsoonite = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./config.nix
      ];
    };
  };
}
