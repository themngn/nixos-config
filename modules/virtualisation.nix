{ ... }:
{
  virtualisation.vmware.host.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  virtualisation.waydroid.enable = true;
}
