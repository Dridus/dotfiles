{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.docker ];
    sessionVariables.COLIMA_SAVE_CONFIG = "0";
  };

  services.colima = {
    enable = true;
    profiles.default.isActive = true;
    profiles.default.settings = {
      cpu = 18;
      disk = 100;
      memory = 24;
      arch = "aarch64";
      runtime = "docker";
      modelRunner = "docker";
      hostname = "colima";
      kubernetes = {
        enabled = false;
        version = "v1.35.0+k3s1";
        k3sArgs = [ "--disable=traefik" ];
        port = 0;
      };
      autoActivate = true;
      network = {
        address = true;
        mode = "shared";
        interface = "en0";
        preferredRoute = false;
        dns = [ ];
        dnsHosts = { };
        hostAddresses = false;
        gatewayAddress = "192.168.5.2";
      };
      forwardAgent = true;
      docker = { };
      vmType = "vz";
      portForwarder = "ssh";
      rosetta = false;
      binfmt = true;
      nestedVirtualization = false;
      mountType = "virtiofs";
      mountInotify = true;
      cpuType = "";
      provision = [ ];
      sshConfig = true;
      sshPort = 0;
      mounts = [ ];
      diskImage = "";
      rootDisk = 20;
      env = { };
    };
  };

}
