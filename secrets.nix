let
  admin = "age15akskah37k32fqnktxhh58y9kdhmu3ce4gtw07j49qtfhtjjsvtq8z78hq";
  copland = "age1egtkxm54e8gwsvn42sz37cv5x5yj2pkp3x5fwwv2s3ux0cupscmqya3mye";
in
{
  "modules/nixos/common/secrets/radicle.age".publicKeys = [
    admin
    copland
  ];
}
