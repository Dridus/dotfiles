{
  inputs = {
    local = {
      url = "path:/etc/nixos/system-config-local";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/release-23.11";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.lightbreaker = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ({lib, ...}: {
          nix.registry.nixpkgs.flake = nixpkgs;
          system = {
            configurationRevision = lib.mkIf (self ? rev) self.rev;
            stateVersion = "23.11";
          };
        })
        "${inputs.local}/config-local.nix"
        ./hardware.nix
        ./config.nix
      ];
    };
  };
}
