{
  inputs = {
    local = {
      url = "path:/etc/nixos";
      flake = false;
    };
    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon/6e324ab06cb27a19409ebc1dc2664bf1e585490a";
    nixpkgs.follows = "nixos-apple-silicon/nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixos-apple-silicon,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.radiance = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ({lib, ...}: {
          hardware.asahi.peripheralFirmwareDirectory = "${inputs.local}/firmware";
          nix.registry.nixpkgs.flake = nixpkgs;
          system = {
            configurationRevision = lib.mkIf (self ? rev) self.rev;
            stateVersion = "24.05";
          };
        })
        nixos-apple-silicon.nixosModules.default
        "${inputs.local}/config-local.nix"
        ./hardware.nix
        ./config.nix
      ];
    };
  };
}
