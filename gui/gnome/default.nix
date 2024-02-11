{pkgs, ...}: {
  home.packages = [
    pkgs.gnome.gnome-tweaks
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.system-monitor-next
  ];
}
