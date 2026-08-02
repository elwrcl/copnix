let
  admin = "age15akskah37k32fqnktxhh58y9kdhmu3ce4gtw07j49qtfhtjjsvtq8z78hq";
  copland = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgUfagBReTu/DeK1psJ7fi8vZwoTGZiKQzeuGsopg+a root@copland";
in
{
  "modules/nixos/common/secrets/radicle.age".publicKeys = [
    admin
    copland
  ];
}
