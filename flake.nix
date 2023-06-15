{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-22.11";
      flake = false;
    };
    nixpkgsUnstable = {
      url = "github:NixOS/nixpkgs/f00994e78cd39e6fc966f0c4103f908e63284780";
      flake = false;
    };
    nil.url = "github:oxalica/nil";
  };
  outputs = { ... }: {};
}
