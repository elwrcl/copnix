{ pkgs, ... }:

pkgs.linuxManualConfig {
  stdenv = pkgs.llvmPackages.stdenv;

  src = pkgs.fetchurl {
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.1.3.tar.xz";
    sha256 = pkgs.lib.fakeSha256;
  };

  version = "7.1.3-lfbmq";
  modDirVersion = "7.1.3-lfbmq";
  pname = "linux-lfbmq";
  configfile = ./lfbmq.config;
  allowImportFromDerivation = true;
  extraMakeFlags = [ "LLVM=1" ];

  kernelPatches = [
    {
      name = "prjc-cachy-lfbmq";
      patch = ./patches/0001-prjc-cachy-lfbmq.patch;
    }
    {
      name = "clang-polly";
      patch = ./patches/0001-clang-polly.patch;
    }
    {
      name = "acpi-call";
      patch = ./patches/0001-acpi-call.patch;
    }
    {
      name = "more-uarches";
      patch = ./patches/more-ISA-levels-and-uarches-for-kernel-6.16+.patch;
    }
  ];
}
