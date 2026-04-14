{ config, pkgs, lib, inputs, ... }:

let
  ocPath = "/boot/EFI/OC";
  liminePath = "/boot/EFI/limine";

  ocPkg = pkgs.fetchzip {
    url = "https://github.com/acidanthera/OpenCorePkg/releases/download/1.0.1/OpenCore-1.0.1-RELEASE.zip";
    sha256 = "sha256-uKn0HlXQLDgZaYjRL3QcoqZ3iji0klz4pxYoLphP5rs=";
    stripRoot = false;
  };

  ocResources = pkgs.fetchzip {
    url = "https://github.com/acidanthera/OcBinaryData/archive/refs/heads/master.zip";
    sha256 = "sha256-B5CABp0Y2dAVuw7185suaUuryl3iII4QNBVBttivQ7Y=";
  };
in
{
  system.activationScripts.opencoreConfig = {
    text = ''
            echo "--- Copland Bootloader ---"
      
            mkdir -p ${ocPath}/Drivers
            mkdir -p ${ocPath}/Resources
            mkdir -p ${liminePath}

            # 1. DOSYALARI KOPYALA
            cp -f ${ocPkg}/X64/EFI/OC/Drivers/*.efi ${ocPath}/Drivers/
            cp -rf ${ocResources}/Resources/* ${ocPath}/Resources/
      
            if [ -f ${pkgs.limine}/share/limine/BOOTX64.EFI ]; then
              cp -f ${pkgs.limine}/share/limine/BOOTX64.EFI ${liminePath}/BOOTX64.EFI
            fi

            cat <<EOF > ${liminePath}/limine.conf
      TIMEOUT=5
      GRAPHICS=yes
      INTERFACE_RESOLUTION=1366x768

      :NixOS (CachyOS)
          PROTOCOL=efi_chainload
          IMAGE_PATH=boot:///EFI/systemd/systemd-bootx64.efi
      EOF

            cat <<EOF > ${ocPath}/config.plist
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Booter</key>
          <dict>
              <key>Quirks</key>
              <dict>
                  <key>AvoidRuntimeDefrag</key><true/>
                  <key>EnableWriteUnprotector</key><true/>
                  <key>ProvideCustomSlide</key><true/>
                  <key>SetupVirtualMap</key><true/>
              </dict>
          </dict>

          <key>Misc</key>
          <dict>
              <key>Boot</key>
              <dict>
                  <key>PickerMode</key><string>Builtin</string>
                  <key>PickerAttributes</key><integer>1</integer>
                  <key>ShowPicker</key><true/>
                  <key>Timeout</key><integer>10</integer>
              </dict>
              <key>Security</key>
              <dict>
                  <key>AllowSetDefault</key><true/>
                  <key>AuthRestart</key><false/>
                  <key>BlacklistAppleUpdate</key><true/>
                  <key>DmgLoading</key><string>Signed</string>
                  <key>EnablePassword</key><false/>
                  <key>ExposeSensitiveData</key><integer>6</integer>
                  <key>HaltLevel</key><integer>2147483648</integer>
                  <key>PasswordHash</key><data></data>
                  <key>PasswordSalt</key><data></data>
                  <key>ScanPolicy</key><integer>0</integer>
                  <key>SecureBootModel</key><string>Disabled</string>
                  <key>Vault</key><string>Optional</string>
              </dict>
              <key>Entries</key>
              <array>
                  <dict>
                      <key>Name</key><string>Limine</string>
                      <key>Enabled</key><true/>
                      <key>Path</key><string>PciRoot(0x0)/Pci(0x1f,0x2)/Sata(2,0,0)/HD(1,GPT,73ae5e9a-c31d-4787-9792-ee1843de3e9d,0x800,0x200000)/\EFI\limine\BOOTX64.EFI</string>
                  </dict>
              </array>
          </dict>

          <key>PlatformInfo</key>
          <dict>
              <key>Generic</key>
              <dict>
                  <key>AdviseFeatures</key><true/>
                  <key>SystemProductName</key><string>MacBookPro16,1</string>
                  <key>SystemUUID</key><string>5445524E-A59B-4D8B-9B2F-9876543210AB</string>
                  <key>ROM</key><data>ABEiM0RV</data>
              </dict>
          </dict>

          <key>UEFI</key>
          <dict>
              <key>ConnectDrivers</key><true/>
              <key>Input</key>
              <dict>
                  <key>KeySupport</key><true/>
                  <key>KeySupportMode</key><string>Auto</string>
              </dict>
              <key>Output</key>
              <dict>
                  <key>ProvideConsoleGop</key><true/>
                  <key>Resolution</key><string>Max</string>
                  <key>TextRenderer</key><string>BuiltinGraphics</string>
              </dict>
              <key>Quirks</key>
              <dict>
                  <key>ReleaseUsbOwnership</key><true/>
                  <key>RequestBootVarRouting</key><true/>
                  <key>DisableSecurityPolicy</key><true/>
              </dict>
              <key>Drivers</key>
              <array>
                  <string>OpenRuntime.efi</string>
                  <string>OpenLinuxBoot.efi</string>
                  <string>OpenUsbKbDxe.efi</string>
                  <string>OpenCanopy.efi</string>
              </array>
          </dict>
      </dict>
      </plist>
      EOF

            # 4. BIOS KAYDI
            if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "OpenCore_Copland"; then
              ${pkgs.efibootmgr}/bin/efibootmgr -c -d /dev/sda -p 1 -L "OpenCore_Copland" -l "\EFI\OC\OpenCore.efi"
            fi
    '';
  };
}
