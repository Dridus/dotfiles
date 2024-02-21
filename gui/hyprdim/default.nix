{ pkgs, ... }: {
  systemd.user.services.hyprdim = {
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };

    Service = {
      ExecStart = "${pkgs.hyprdim}/bin/hyprdim --persist";
    };

    Install.WantedBy = ["hyprland-session.target"];
  };
}
