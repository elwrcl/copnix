{ ... }:
{
  flake.homeModules.home-zellij =
    { ... }:
    {
      programs.zellij = {
        enable = true;

        settings = {
          theme = "kanagawa-dragon-copnix";
          default_layout = "compact";
          default_mode = "normal";
          default_shell = "nu";
          pane_frames = false;
          ui.pane_frames.rounded_corners = true;
          mouse_mode = true;
          copy_command = "wl-copy";
          copy_on_select = true;
          styled_underlines = true;
          support_kitty_keyboard_protocol = true;
          stacked_resize = true;
          scroll_buffer_size = 50000;
          scrollback_editor = "hx";
          session_serialization = true;
          serialize_pane_viewport = true;
          on_force_close = "detach";
          show_startup_tips = false;
          show_release_notes = false;
        };
      };
    };
}
