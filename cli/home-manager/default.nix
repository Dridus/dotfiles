{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    concatMapStringsSep
    mkOption
    optionalString
    toShellVar
    types
    ;

  hm = pkgs.writeShellApplication {
    name = "hm";
    runtimeInputs = [pkgs.home-manager];
    text = ''
      ${toShellVar "FOOS_SOURCE_ROOT" config.dotfiles.foosSourceRoot}
      ${toShellVar "HOME_FLAKE" config.dotfiles.homeFlake}
      export FOOS_SOURCE_ROOT HOME_FLAKE
      ${
        optionalString (config.dotfiles.homeFlakeLocalInputs != []) ''
          # FIXME ideally this would somehow only happen if the input has truly changed to avoid
          # breaking the eval cache and things. however, to do that would be a little complicated
          # and/or depend on knowing the out-of-store path. this is because update-input always
          # updates the whole input (sensibly) but that input is changing because the flake.lock
          # in question is also changing, even if only to bump the last modified. hacks involving
          # the flake.lock are made more complicated by the flake reference being git+file,
          # meaning finding the source tree is possible but a bit complicated to parse the URL.
          ${pkgs.nixFlakes}/bin/nix flake lock ${
            concatMapStringsSep " " (input: "--update-input ${input}") config.dotfiles.homeFlakeLocalInputs
          } "$HOME_FLAKE"
        ''
      }
      home-manager --impure --flake "$HOME_FLAKE" "$@"
    '';
  };

  hmrepl = pkgs.writeShellApplication {
    name = "hmrepl";
    runtimeInputs = [];
    text = ''
      ${toShellVar "HOME_FLAKE" config.dotfiles.homeFlake}
      export HOME_FLAKE
      nix repl --impure "$HOME_FLAKE"
    '';
  };
in {
  options = {
    dotfiles = {
      foosSourceRoot = mkOption {
        type = types.str;
        default = "";
        description = ''
          Out of store source path to use when applying the home-manager configuration. If set, then many config files will be
          symlinks directly into this source directory rather than pure copies in the nix store. This breaks purity to gain the
          ability to change config files without applying a new home-manager configuration.
        '';
      };

      homeFlake = mkOption {
        type = types.str;
        default = [];
        description = ''
          Path to the home flake.nix, since putting the home.nix in ~/.config/home-manager means that the flake must be at the top
          level, which is isn't for my dotfiles, and path: schemes don't support ?dir but the flakes don't only refer to things in
          the same folder.
        '';
      };

      homeFlakeLocalInputs = mkOption {
        type = types.listOf types.str;
        description = ''
          Flake inputs of the home flake to update the lock of prior to invoking home-manager. This is to make it easier to use the
          local flake references, which are generally obnoxious.
        '';
      };
    };
  };

  config = {
    home.packages = [hm hmrepl];
    programs.home-manager.enable = true;
  };
}
