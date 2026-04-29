{ ... }:
{
  # virtualisation.vmware.host.enable = true;

  /*
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  */

  # services.k3s.enable = true;
  # services.k3s.role = "server";
}
