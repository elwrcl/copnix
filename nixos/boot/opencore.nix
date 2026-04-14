{ config, pkgs, lib, ... }:

let
  ocPath = "/boot/EFI/OC";
in
{
  environment.systemPackages = [ pkgs.efibootmgr ];

  system.activationScripts.opencoreConfig = {
    text = ''
            echo "--- Copland Init ---"
      
            mkdir -p ${ocPath}

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
                  <key>EnableSafeModeCaching</key><true/>
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
                  <key>PickerMode</key><string>External</string> <key>PickerAttributes</key><integer>17</integer>
                  <key>Timeout</key><integer>5</integer>
              </dict>
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

          <key>UEFI</key>
          <dict>
              <key>Input</key>
              <dict>
                  <key>KeySupport</key><true/> <key>KeySupportMode</key><string>Auto</string>
                  <key>ReleaseUsbOwnership</key><true/> </dict>
              <key>Drivers</key>
              <array>
                  <string>OpenRuntime.efi</string>
                  <string>OpenCanopy.efi</string> <string>OpenLinuxBoot.efi</string>
                  <string>OpenUsbKbDxe.efi</string>
              </array>
          </dict>
      </dict>
      </plist>
    '';
  };
}
