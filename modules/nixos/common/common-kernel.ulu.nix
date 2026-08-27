{ ... }:
{
  flake.nixosModules.common-kernel =
    { pkgs, ... }:
    {
      # interesting...
      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.kernelParams = [
        "mitigations=off"
        "nmi_watchdog=1"
        "transparent_hugepage=madvise"
      ];

      boot.kernelModules = [
        "tcp_bbr"
        "sch_fq"
      ];

      boot.kernel.sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
      };
    };
}
