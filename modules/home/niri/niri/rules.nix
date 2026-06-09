{ ... }:

{
  programs.niri.settings = {
    window-rules = [
      {
        matches = [ { title = "Open File.*"; } ];
        open-floating = true;
      }
      {
        matches = [ { title = "Save As.*"; } ];
        open-floating = true;
      }
      {
        matches = [ { title = "File Upload.*"; } ];
        open-floating = true;
      }
      {
        matches = [ { "app-id" = "pavucontrol"; } ];
        open-floating = true;
        default-column-width = { fixed = 800; };
      }
      {
        matches = [ { title = "(?i)picture.in.picture"; } ];
        open-floating = true;
      }
      {
        matches = [ { "app-id" = "steam"; } ];
        open-floating = true;
      }
      {
        matches = [ { "app-id" = "steam"; title = "Steam"; } ];
        open-floating = false;
      }
      {
        matches = [ { "app-id" = "steam"; title = "^notificationtoasts_.*"; } ];
        open-floating = true;
        open-focused = false;
        default-floating-position = {
          x = 20;
          y = 20;
          "relative-to" = "bottom-right";
        };
      }
    ];
  };
}