{ pkgs, inputs, ... }:

let
  ocPath = "/boot/EFI/OC";

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
      (
        { ... }:
        {
          # Register kext packages so they get copied into the EFI intermediate package
          # and auto-discovered by mkKexts
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

            Kernel.Quirks = {
              AppleCpuPmCfgLock = true;
              AppleXcpmCfgLock = true;
              DisableIoMapper = true;
              LapicKernelPanic = false;
              PanicNoKextDump = true;
              PowerTimeoutKernelPanic = true;
              XhciPortLimit = false;
            };

            Booter.Quirks = {
              AvoidRuntimeDefrag = true;
              EnableSafeModeSlide = true;
              EnableWriteUnprotector = true;
              ProvideCustomSlide = true;
              RebuildAppleMemoryMap = true;
              SetupVirtualMap = true;
              SyncRuntimePermissions = true;
            };

            DeviceProperties.Add."PciRoot(0x0)/Pci(0x2,0x0)" = {
              "AAPL,ig-platform-id" = "03006601";
              "device-id" = "66010000";
            };

            # nvram
            NVRAM.Add."7C436110-AB2A-4BBB-A880-FE41995C9F82" = {
              # ipc_control_port_options=0
              # amfi_get_out_of_my_way=0x1
              # revpatch=sbvmm,f16c
              # revblock=media
              "boot-args" =
                "ipc_control_port_options=0 amfi_get_out_of_my_way=0x1 -no-compat-check revpatch=sbvmm,f16c revblock=media";
              "csr-active-config" = pkgs.lib.mkForce "AwgAAA==";
            };

            UEFI.Output.ProvideConsoleGop = true;
            UEFI.Output.Resolution = "1366x768";
            UEFI.Output.TextRenderer = "BuiltinGraphics";

            UEFI.Audio = {
              AudioCodec = 0;
              AudioDevice = "PciRoot(0x0)/Pci(0x1b,0x0)";
              AudioOutMask = 1;
              AudioSupport = true;
              ResetTrafficClass = true;
              DisconnectHda = false;
              MaximumGain = -10;
              MinimumAssistGain = -30;
              MinimumAudibleGain = -128;
              PlayChime = "Enabled";
              SetupDelay = 0;
            };

            UEFI.AppleInput = {
              AppleEvent = "Builtin";
              CustomDelays = false;
              GraphicsInputMirroring = true;
              KeyInitialDelay = 50;
              KeySubsequentDelay = 5;
              PointerPollMask = -1;
              PointerPollMin = 10;
              PointerPollMax = 80;
              PointerSpeedDiv = 1;
              PointerSpeedMul = 1;
            };

            Misc.Boot.PickerMode = "External";
            Misc.Boot.PickerVariant = "Acidanthera\\Syrah";
            Misc.Boot.PickerAttributes = 144;
            Misc.Boot.Timeout = 15;
            Misc.Boot.HideAuxiliary = false;

            Misc.Debug = {
              AppleDebug = true;
              ApplePanic = true;
              DisableWatchDog = true;
              DisplayLevel = 2147483650;
              Target = 3;
            };

            Misc.Security.SecureBootModel = "Disabled";
            Misc.Security.ScanPolicy = 0;
            Misc.Security.Vault = "Optional";
            UEFI.Quirks.DisableSecurityPolicy = true;
            UEFI.Quirks.ReleaseUsbOwnership = true;
            UEFI.Quirks.RequestBootVarRouting = true;

            # spoofer
            PlatformInfo.Automatic = true;
            PlatformInfo.UpdateSMBIOSMode = "Create";
            PlatformInfo.Generic = {
              SystemProductName = "MacBookPro10,2";
              SystemSerialNumber = "C02J603FDR53";
              SystemUUID = "2B8E7220-2B6A-4595-B254-930EE04E752A";
              MLB = "C02232403J9F16P1F";
              ROM = "F0B0E7AC067D";
            };

            UEFI.Drivers."OpenRuntime.efi".Enabled = true;
            UEFI.Drivers."OpenCanopy.efi".Enabled = true;
            UEFI.Drivers."OpenLinuxBoot.efi".Enabled = true;
            UEFI.Drivers."AudioDxe.efi".Enabled = true;

            Misc.Entries = [ ];
          };
        }
      )
    ];
  };

in
{
  system.activationScripts.opencoreConfig = {
    text = ''
      echo "--- Kopurando In1t ---"

      if [ ! -d "${ocPath}" ] || ! ${pkgs.diffutils}/bin/diff -r "${ocConfig.efiPackage}/EFI/OC" "${ocPath}" >/dev/null 2>&1; then
        echo "diffs are detected, writing EFI files..."
        rm -rf ${ocPath}
        mkdir -p ${ocPath}
        cp -rf ${ocConfig.efiPackage}/EFI/OC/* ${ocPath}/
        mkdir -p ${ocPath}/Resources
        cp -rf ${ocResources}/Resources/* ${ocPath}/Resources/
      else
        echo "EFI is already up to date."
      fi

      BOOT_DEV=$(${pkgs.util-linux}/bin/findmnt -n -o SOURCE /boot)

      if [ -n "$BOOT_DEV" ]; then
        TARGET_DISK=$(echo "$BOOT_DEV" | ${pkgs.gnused}/bin/sed -E 's/p?[0-9]+$//')
        PART_NUM=$(echo "$BOOT_DEV" | ${pkgs.gnugrep}/bin/grep -oE '[0-9]+$')

        if ! ${pkgs.efibootmgr}/bin/efibootmgr | ${pkgs.gnugrep}/bin/grep -q "OpenCore_Copland"; then
          echo "Registering OpenCore on $TARGET_DISK (partition $PART_NUM)..."
          ${pkgs.efibootmgr}/bin/efibootmgr -c -d "$TARGET_DISK" -p "$PART_NUM" -L "OpenCore_Copland" -l "\\EFI\\OC\\OpenCore.efi"
        fi
      else
        echo "Error: Could not find mount point for /boot!"
      fi
    '';
  };
}
