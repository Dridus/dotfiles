{
  config,
  pkgs,
  ...
}: {
  assertions = [
    {
      assertion = config.programs.zsh.enable;
      message = "cli/keychain expects zsh";
    }
  ];

  home.packages = [pkgs.keychain];

  programs.zsh.initExtraFirst = ''
    if [ -f "$HOME/.ssh/id_rsa" ]; then
      ${pkgs.keychain}/bin/keychain --nogui $HOME/.ssh/id_rsa
    fi

    if [ -f "$HOME/.ssh/id_ed25519" ]; then
      ${pkgs.keychain}/bin/keychain --nogui $HOME/.ssh/id_ed25519
    fi

    if [ -z "$SSH_AUTH_SOCK" ]; then
      source $HOME/.keychain/$(hostname)-sh
    fi
  '';
}
