{
  inputs = {
    local = {
      url = "path:/etc/nixos";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.illuminance = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ({lib, ...}: {
          nix.registry.nixpkgs.flake = nixpkgs;
          system = {
            configurationRevision = lib.mkIf (self ? rev) self.rev;
            stateVersion = "24.05";
          };
        })
        "${inputs.local}/config-local.nix"
        ./hardware.nix
        ./config.nix
      ];
    };
  };
}
