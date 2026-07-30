{ ... }:
{
  commonModules.hostname-assert =
    { config, lib, ... }:
    {
      options.elars.expectedHostName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "host filename must match networking.hostName.";
      };

      config.assertions = lib.singleton {
        assertion =
          config.elars.expectedHostName == null
          || config.networking.hostName == config.elars.expectedHostName;
        message = ''
          syntax: hostname assertion failed:
           expected (filename) : ${toString config.elars.expectedHostName}
           real (networking)  : ${toString config.networking.hostName}
        '';
      };
    };
}
