{ pkgs, ... }: {
  home = {
    packages = [ pkgs.bat ];
    sessionVariables.BAT_THEME = "OneHalfDark";
  };
}


