{ inputs, ... }:
{
  imports = [ inputs.nixos-vscode-server.homeModules.default ];
  services.vscode-server.enable = true;
}
