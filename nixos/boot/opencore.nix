{ pkgs, inputs, ... }:

let
  ocPath = "/boot/EFI/OC";

  # for debugging
  ocDebug = false;

  oceanixPkgs = import pkgs.path {
    localSystem = pkgs.stdenv.hostPlatform;
    inherit (pkgs) config;
    overlays = [ inputs.oceanix.overlays.default ];
  };

  mkKext =
    {
      pname,
      version,
      url,
      sha256,
    }:
    pkgs.stdenv.mkDerivation {
      inherit pname version;
      src = pkgs.fetchurl { inherit url sha256; };
      nativeBuildInputs = [ pkgs.unzip ];
      sourceRoot = ".";
      installPhase = ''
        runHook preInstall
        mkdir -p $out/Kexts
        cp -r *.kext $out/Kexts/
        runHook postInstall
      '';
    };

  amfipass = mkKext {
    pname = "amfipass";
    version = "1.4.1";
    url = "https://github.com/bluppus20/AMFIPass/releases/download/1.4.1/AMFIPass-v1.4.1-RELEASE.zip";
    sha256 = "07lnvh585y0p8kw6byn1ij42iskkn7xkhy9sn7s43nq6b4a6dch7";
  };

  cryptexfixup = mkKext {
    pname = "cryptexfixup";
    version = "1.0.2";
    url = "https://github.com/acidanthera/CryptexFixup/releases/download/1.0.2/CryptexFixup-1.0.2-RELEASE.zip";
    sha256 = "0pdh02gcxgndadzsllmmncpy2ipnzk8n97hdkylx1lcvfjafbiim";
  };

  restrictevents = mkKext {
    pname = "restrictevents";
    version = "1.1.3";
    url = "https://github.com/acidanthera/RestrictEvents/releases/download/1.1.3/RestrictEvents-1.1.3-RELEASE.zip";
    sha256 = "1s18k25hpbxg59rwpgiwr5p7ci70fzbp99f93lap5a77yl9rbj2l";
  };

  voodoops2 = mkKext {
    pname = "voodoops2controller";
    version = "2.3.6";
    url = "https://github.com/acidanthera/VoodooPS2/releases/download/2.3.6/VoodooPS2Controller-2.3.6-RELEASE.zip";
    sha256 = "sha256-N15qzXc12ZPjLNpmqEklVPtfSRKss1LEPU6uPLByANk=";
  };

  airportitlwm = mkKext {
    pname = "airportitlwm";
    version = "2.3.0";
    url = "https://github.com/OpenIntelWireless/itlwm/releases/download/v2.3.0/AirportItlwm_v2.3.0_stable_Sonoma14.4.kext.zip";
    sha256 = "sha256-fvEqgDfrm8eVgow0j0+gcouK3leqCYSwN4Fu+RwtURk=";
  };

  ocResources = pkgs.fetchzip {
    url = "https://github.com/acidanthera/OcBinaryData/archive/refs/heads/master.zip";
    sha256 = "sha256-B5CABp0Y2dAVuw7185suaUuryl3iII4QNBVBttivQ7Y=";
  };

  ocConfig = inputs.oceanix.lib.OpenCoreConfig {
    pkgs = oceanixPkgs;
    modules = [
      ({ ... }: {

        oceanix.opencore.resources.packages = [
          oceanixPkgs."lilu-latest-release"
          oceanixPkgs."virtualsmc-latest-release"
          oceanixPkgs."whatevergreen-latest-release"
          oceanixPkgs."applealc-latest-release"
          oceanixPkgs."intel-mausi-latest-release"
          voodoops2
          airportitlwm
          amfipass
          cryptexfixup
          restrictevents
        ];

        oceanix.opencore.settings = {
          Kernel.Add."Lilu.kext".Enabled = true;
          Kernel.Add."VirtualSMC.kext".Enabled = true;
          Kernel.Add."SMCBatteryManager.kext".Enabled = true;
          Kernel.Add."SMCProcessor.kext".Enabled = true;
          Kernel.Add."WhateverGreen.kext".Enabled = true;
          Kernel.Add."AppleALC.kext".Enabled = true;
          Kernel.Add."IntelMausi.kext".Enabled = true;
          Kernel.Add."VoodooPS2Controller.kext".Enabled = true;
          Kernel.Add."AirportItlwm.kext".Enabled = true;
          Kernel.Add."AMFIPass.kext".Enabled = true;
          Kernel.Add."CryptexFixup.kext".Enabled = true;
          Kernel.Add."RestrictEvents.kext".Enabled = true;

          # boot menu
          Misc.Boot.PickerMode = "Builtin";
          Misc.Boot.PickerVariant = "Auto";
          Misc.Boot.PickerAttributes = 0;
          Misc.Boot.Timeout = 15;
          Misc.Boot.HideAuxiliary = false;


          Misc.Tools."OpenShell.efi".Enabled = true;
          Misc.Tools."OpenShell.efi".Name = "OpenShell";
          Misc.Tools."OpenShell.efi".Auxiliary = true;

          Misc.Tools."CleanNvram.efi".Enabled = true;
          Misc.Tools."CleanNvram.efi".Name = "Reset NVRAM";
          Misc.Tools."CleanNvram.efi".Auxiliary = true;


          UEFI.Drivers."ResetNvramEntry.efi".Enabled = true;
        };
      })
    ];
  };

in
{
  system.activationScripts.opencoreConfig = {
    text = ''
      set -euo pipefail
      echo "--- Kopurando In1t ---"

      if [ ! -d "${ocPath}" ] || ! ${pkgs.diffutils}/bin/diff -r "${ocConfig.efiPackage}/EFI/OC" "${ocPath}" >/dev/null 2>&1; then
        echo "diffs are detected, writing EFI files..."
        rm -rf "${ocPath}"
        mkdir -p "${ocPath}"
        cp -rf "${ocConfig.efiPackage}/EFI/OC/"* "${ocPath}/"
        mkdir -p "${ocPath}/Resources"
        cp -rf "${ocResources}/Resources/"* "${ocPath}/Resources/"
      else
        echo "EFI is already up to date."
      fi

      BOOT_DEV="$(${pkgs.util-linux}/bin/findmnt -n -o SOURCE /boot)"

      if [ -n "$BOOT_DEV" ]; then
        TARGET_DISK="$(echo "$BOOT_DEV" | ${pkgs.gnused}/bin/sed -E 's/p?[0-9]+$//')"
        PART_NUM="$(echo "$BOOT_DEV" | ${pkgs.gnugrep}/bin/grep -oE '[0-9]+$')"

        if ! ${pkgs.efibootmgr}/bin/efibootmgr | ${pkgs.gnugrep}/bin/grep -q "OpenCore_Copland"; then
          echo "Registering OpenCore on $TARGET_DISK (partition $PART_NUM)..."
          ${pkgs.efibootmgr}/bin/efibootmgr -c -d "$TARGET_DISK" -p "$PART_NUM" -L "OpenCore_Copland" -l '\EFI\OC\OpenCore.efi'
        fi
      else
        echo "Error: Could not find mount point for /boot!"
      fi
    '';
  };
}
