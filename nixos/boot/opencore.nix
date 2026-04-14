{ config, pkgs, lib, inputs, ... }:

let
  ocPath = "/boot/EFI/OC";
  liminePath = "/boot/EFI/limine";
  ocDrivers = "${inputs.oceanix.packages.${pkgs.system}.opencore}/EFI/OC/Drivers";
in
{
  system.activationScripts.opencoreConfig = {
    text = ''
            echo "--- Copland Bootloader ---"
      
            mkdir -p ${ocPath}/Drivers
            mkdir -p ${liminePath}

            # EKSİK SÜRÜCÜLERİ BURADA MANUEL KOPYALIYORUZ
            cp -f ${ocDrivers}/OpenCanopy.efi ${ocPath}/Drivers/
            cp -f ${ocDrivers}/OpenUsbKbDxe.efi ${ocPath}/Drivers/
            # Bunlar sende vardı ama garanti olsun diye üzerinden geçiyoruz
            cp -f ${ocDrivers}/OpenRuntime.efi ${ocPath}/Drivers/
            cp -f ${ocDrivers}/OpenLinuxBoot.efi ${ocPath}/Drivers/

            if [ -f ${pkgs.limine}/share/limine/BOOTX64.EFI ]; then
              cp -f ${pkgs.limine}/share/limine/BOOTX64.EFI ${liminePath}/BOOTX64.EFI
            fi

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
                  <key>SetupVirtualMap</key><true/>
                  <key>ProvideCustomSlide</key><true/>
              </dict>
          </dict>

          <key>DeviceProperties</key>
          <dict>
              <key>Add</key>
              <dict>
                  <key>PciRoot(0x0)/Pci(0x2,0x0)</key>
                  <dict>
                      <key>AAPL,ig-platform-id</key><data>AwBmAQ==</data>
                      <key>framebuffer-patch-enable</key><data>AQAAAA==</data>
                  </dict>
              </dict>
          </dict>

          <key>Misc</key>
          <dict>
              <key>Boot</key>
              <dict>
                  <key>PickerMode</key><string>External</string>
                  <key>PickerAttributes</key><integer>17</integer>
                  <key>Timeout</key><integer>5</integer>
              </dict>
              <key>Entries</key>
              <array>
                  <dict>
                      <key>Name</key><string>Limine</string>
                      <key>Enabled</key><true/>
                      <key>Path</key><string>PciRoot(0x0)/Pci(0x1f,0x2)/Sata(2,0,0)/HD(1,GPT,73ae5e9a-c31d-4787-9792-ee1843de3e9d,0x800,0x200000)/\EFI\limine\BOOTX64.EFI</string>
                  </dict>
              </array>
              <key>Security</key>
              <dict>
                  <key>AllowSetDefault</key><true/>
                  <key>ScanPolicy</key><integer>0</integer>
                  <key>Vault</key><string>Optional</string>
              </dict>
          </dict>

          <key>NVRAM</key>
          <dict>
              <key>Add</key>
              <dict>
                  <key>7C436110-AB2A-4BBB-A880-FE41995C9F82</key>
                  <dict>
                      <key>boot-args</key>
                      <string>-v amfi_get_out_of_my_way=1 -no_compat_check ipc_control_port_options=0</string>
                  </dict>
              </dict>
          </dict>

          <key>PlatformInfo</key>
          <dict>
              <key>Generic</key>
              <dict>
                  <key>SystemProductName</key><string>MacBookPro16,1</string>
                  <key>AdviseFeatures</key><true/>
              </dict>
          </dict>

          <key>UEFI</key>
          <dict>
              <key>Input</key>
              <dict>
                  <key>KeySupport</key><true/>
                  <key>KeySupportMode</key><string>Auto</string>
                  <key>ReleaseUsbOwnership</key><true/>
              </dict>
              <key>Drivers</key>
              <array>
                  <string>OpenRuntime.efi</string>
                  <string>OpenCanopy.efi</string>
                  <string>OpenLinuxBoot.efi</string>
                  <string>OpenUsbKbDxe.efi</string>
              </array>
          </dict>
      </dict>
      </plist>
      EOF
    '';
  };
}
