{ ... }:
{
  virtualisation.vmware.host.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  virtualisation.waydroid.enable = true;

  services.k3s.enable = true;
  services.k3s.role = "server";
}
