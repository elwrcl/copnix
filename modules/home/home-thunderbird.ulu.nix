{ ... }:
{
  flake.homeModules.home-thunderbird =
    { ... }:
    {
      programs.thunderbird = {
        enable = true;
        profiles.default = {
          isDefault = true;
          settings = {
            "mail.shell.checkDefaultClient" = false;
            "mailnews.start_page.enabled" = false;
            "mail.provider.enabled" = false;
            "mailnews.message_display.disable_remote_image" = true;
            "privacy.donottrackheader.enabled" = true;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            "app.update.auto" = false;
            "intl.date_time.pattern_override.date_short" = "dd.MM.yyyy";
            "ui.systemUsesDarkTheme" = 1;
            "font.name.monospace.x-western" = "JetBrainsMono Nerd Font Mono";
          };
        };
      };
    };
}
