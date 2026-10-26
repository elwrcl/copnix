{ ... }:
{
  flake.nixosModules.service-docker =
    { ... }:
    {
      # Rootless: the daemon runs as the user, so access to it isn't root
      # (membership in the `docker` group of a rootful daemon would be).
      # setSocketVariable points DOCKER_HOST at the user's socket.
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
}
