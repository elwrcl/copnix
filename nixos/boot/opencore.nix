{ pkgs, inputs, ... }:

let
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

 # amfipass = mkKext {
 #   pname = "amfipass";
 #   version = "1.4.1";
 #   url = "https://github.com/bluppus20/AMFIPass/releases/download/1.4.1/AMFIPass-v1.4.1-RELEASE.zip";
 #   sha256 = "07lnvh585y0p8kw6byn1ij42iskkn7xkhy9sn7s43nq6b4a6dch7";
 # };

 # cryptexfixup = mkKext {
 #   pname = "cryptexfixup";
 #   version = "1.0.2";
 #   url = "https://github.com/acidanthera/CryptexFixup/releases/download/1.0.2/CryptexFixup-1.0.2-RELEASE.zip";
 #   sha256 = "0pdh02gcxgndadzsllmmncpy2ipnzk8n97hdkylx1lcvfjafbiim";
 # };

 # restrictevents = mkKext {
 #   pname = "restrictevents";
 #   version = "1.1.3";
 #   url = "https://github.com/acidanthera/RestrictEvents/releases/download/1.1.3/RestrictEvents-1.1.3-RELEASE.zip";
 #   sha256 = "1s18k25hpbxg59rwpgiwr5p7ci70fzbp99f93lap5a77yl9rbj2l";
 # };

  voodoops2 = mkKext {
    pname = "voodoops2controller";
    version = "2.3.6";
    url = "https://github.com/acidanthera/VoodooPS2/releases/download/2.3.6/VoodooPS2Controller-2.3.6-RELEASE.zip";
    sha256 = "sha256-N15qzXc12ZPjLNpmqEklVPtfSRKss1LEPU6uPLByANk=";
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
          oceanix.opencore.resources.packages = [
            oceanixPkgs."lilu-latest-release"
            oceanixPkgs."virtualsmc-latest-release"
            oceanixPkgs."whatevergreen-latest-release"
            oceanixPkgs."applealc-latest-release"
            oceanixPkgs."intel-mausi-latest-release"

            voodoops2
            #amfipass
            #cryptexfixup
            #restrictevents
          ];

          oceanix.opencore.settings = {

            Kernel.Add."Lilu.kext".Enabled = true;
            Kernel.Add."VirtualSMC.kext".Enabled = true;
            Kernel.Add."SMCProcessor.kext".Enabled = true;
            Kernel.Add."WhateverGreen.kext".Enabled = true;
            Kernel.Add."AppleALC.kext".Enabled = true;
            Kernel.Add."IntelMausi.kext".Enabled = true;
            Kernel.Add."VoodooPS2Controller.kext".Enabled = true;
            #Kernel.Add."AMFIPass.kext".Enabled = true;
            #Kernel.Add."CryptexFixup.kext".Enabled = true;
            #Kernel.Add."RestrictEvents.kext".Enabled = true;

            Kernel.Quirks = {
              AppleCpuPmCfgLock = true;
              AppleXcpmCfgLock = false;
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
              SyncRuntimePermissions = false;
            };

            DeviceProperties.Add."PciRoot(0x0)/Pci(0x2,0x0)" = {
              "AAPL,ig-platform-id" = "03006601";
              "device-id" = "66010000";
            };

            NVRAM.Add."7C436110-AB2A-4BBB-A880-FE41995C9F82" = {
              "boot-args" =
                "-v -igfxvesa";
              "csr-active-config" = pkgs.lib.mkForce "AwgAAA==";
            };

            NVRAM.Add."4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102" = {
              "OCLP-Settings" = "-allow_amfi";
            };

            Misc.Boot.PickerMode = "External";
            Misc.Boot.PickerVariant = "Acidanthera\\Syrah";
            Misc.Boot.PickerAttributes = 144;
            Misc.Boot.Timeout = 15;
            Misc.Boot.HideAuxiliary = true;

            Misc.Debug = {
              AppleDebug = true;
              ApplePanic = true;
              DisableWatchDog = true;
              DisplayLevel = 2147483650;
              Target = 3;
            };

            PlatformInfo = {
              Automatic = true;
              UpdateSMBIOSMode = "Create";
              Generic = {
                SystemProductName = "MacBookPro9,2";
                SystemSerialNumber = "C02SN6ZNDTY3";
                MLB = "C02645303GUF1YJCB";
                SystemUUID = "3FD4F7B4-ACD1-44CF-91F2-B4FB16407A57";
                ROM = "0026084E951A";
              };
            };

            Misc.Security.SecureBootModel = "Disabled";
            Misc.Security.ScanPolicy = 0;
            Misc.Security.Vault = "Optional";
            Misc.Security.DmgLoading = "Any";

            Misc.Tools."OpenShell.efi".Enabled = true;
            Misc.Tools."OpenShell.efi".Name = "OpenShell";
            Misc.Tools."OpenShell.efi".Auxiliary = true;
            Misc.Tools."CleanNvram.efi".Enabled = true;
            Misc.Tools."CleanNvram.efi".Name = "Reset NVRAM";
            Misc.Tools."CleanNvram.efi".Auxiliary = true;

            UEFI.Output.ProvideConsoleGop = true;
            UEFI.Output.Resolution = "1366x768";
            UEFI.Output.TextRenderer = "BuiltinGraphics";

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

            UEFI.APFS = {
              MinDate = -1;
              MinVersion = -1;
            };

            UEFI.Drivers."OpenApfsCompatibility.efi".Enabled = true;
            UEFI.Drivers."OpenHfsPlus.efi".Enabled = true;
            UEFI.Drivers."ResetNvramEntry.efi".Enabled = true;
            UEFI.Drivers."OpenRuntime.efi".Enabled = true;
            UEFI.Drivers."OpenCanopy.efi".Enabled = true;
            UEFI.Drivers."OpenLinuxBoot.efi".Enabled = true;
            UEFI.Drivers."AudioDxe.efi".Enabled = true;

            UEFI.Quirks.RequestBootVarRouting = true;
            UEFI.Quirks.DisableSecurityPolicy = true;
            UEFI.Quirks.ReleaseUsbOwnership = true;

            Misc.Entries = [ ];
          };
        }
      )
    ];
  };

in
{
  # system.activationScripts.opencoreConfig = { ... }; usb test

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "oc-paths" ''
      echo "OC_EFI=${ocConfig.efiPackage}/EFI/OC"
      echo "OC_RES=${ocResources}/Resources"
    '')
  ];

}
