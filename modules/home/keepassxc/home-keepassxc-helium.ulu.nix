{ ... }:
{
  flake.homeModules.home-keepassxc-helium =
    { config, ... }:
    {
      xdg.configFile."net.imput.helium/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json".source =
        "${config.programs.keepassxc.package}/etc/chromium/native-messaging-hosts/org.keepassxc.keepassxc_browser.json";
    };
}
