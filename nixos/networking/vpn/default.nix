{ config, pkgs, ... }:

{
  # you can make this true if you have problems with zapret
  services.cloudflare-warp.enable = false;

  # Zapret
  services.zapret = {
    enable = true;
    params = [
      "--filter-tcp=80"
      "--dpi-desync=fake,multisplit"
      "--dpi-desync-split-pos=method+2"
      "--dpi-desync-fooling=md5sig"

      "--new"

      "--filter-tcp=443"
      "--dpi-desync=fake,multidisorder"
      "--dpi-desync-split-pos=1,midsld"
      "--dpi-desync-fooling=badseq,md5sig"

      "--new"

      "--filter-udp=443"
      "--dpi-desync=fake"
      "--dpi-desync-repeats=6"
    ];
  };

  networking.enableIPv6 = false;
}
