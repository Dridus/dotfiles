{ inputs, pkgs, ... }:
let
  forge = inputs.forge.packages.${pkgs.system}.default;
  forgeZshPlugin = pkgs.runCommand "forge-zsh-plugin" { } ''
    export HOME=$(pwd)
    ${forge}/bin/forge zsh plugin > $out
  '';
  forgeZshTheme = pkgs.runCommand "forge-zsh-theme" { } ''
    export HOME=$(pwd)
    ${forge}/bin/forge zsh theme > $out
  '';
in
{
  home.packages = [
    forge
  ];

  programs.zsh = {
    initContent = ''
      eval "$(cat ${forgeZshPlugin})"
      eval "$(cat ${forgeZshTheme})"
    '';

    zplug.plugins = [
      {
        name = "zsh-users/zsh-autosuggestions";
        tags = [ "as:plugin" ];
      }
    ];
  };
}
