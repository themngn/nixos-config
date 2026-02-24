{ ... }:
{
  virtualisation.vmware.host.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
