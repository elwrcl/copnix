{ ... }:
{
  flake.homeModules.home-zed =
    {
      inputs,
      pkgs,
      system,
      ...
    }:
    {
      programs.zed-editor = {
        enable = true;
        package = inputs.gen7-zeditor.packages.${system}.zed-editor;

        userSettings = {
          # ── editor: helix parity ──────────────────────────────────────────
          helix_mode = true;
          relative_line_numbers = "enabled";
          vertical_scroll_margin = 8; # = scrolloff
          cursor_blink = false;
          wrap_guides = [
            80
            100
          ];
          soft_wrap = "editor_width"; # = soft-wrap.enable
          current_line_highlight = "all"; # = cursorline
          indent_guides.enabled = true; # = indent-guides.render
          colorize_brackets = false;
          show_whitespaces = "none";
          sticky_scroll.enabled = false;
          selection_highlight = true;
          seed_search_query_from_cursor = "never";
          drag_and_drop_selection.enabled = false;
          linked_edits = true;
          scroll_beyond_last_line = "off";
          format_on_save = "on";

          # completion / hints
          show_completions_on_input = true;
          hover_popover_delay = 50;
          inlay_hints.enabled = true;
          edit_predictions.provider = "none";

          # ── typography ────────────────────────────────────────────────────
          buffer_font_family = "Obel Mono";
          buffer_font_fallbacks = [ "JetBrainsMono Nerd Font" ];
          buffer_font_weight = 500;
          buffer_font_size = 15;
          buffer_font_features.calt = false; # no ligatures
          buffer_line_height.custom = 1.6;
          ui_font_size = 16;
          window_decorations = "server";
          scrollbar.show = "never";
          minimap.show = "never";
          toolbar = {
            breadcrumbs = false;
            quick_actions = false;
          };
          tab_bar = {
            show_nav_history_buttons = false;
            show_tab_bar_buttons = false;
          };
          tabs = {
            file_icons = true;
            git_status = true;
            show_close_button = "hidden";
          };
          max_tabs = 12;
          title_bar = {
            show_onboarding_banner = false;
            show_user_picture = false;
            show_sign_in = false;
          };
          collaboration_panel.button = false;
          notification_panel.button = false;
          project_panel = {
            dock = "left";
            auto_fold_dirs = false; # = explorer.compactFolders
            indent_size = 16;
            indent_guides.show = "never";
          };
          git_panel.dock = "left";
          outline_panel.dock = "left";
          agent.dock = "right";

          # ── files ─────────────────────────────────────────────────────────
          autosave = "on_focus_change"; # = auto-save.focus-lost
          remove_trailing_whitespace_on_save = true;
          ensure_final_newline_on_save = true;
          file_scan_exclusions = [
            "**/.git"
            "**/.svn"
            "**/.hg"
            "**/.jj"
            "**/.sl"
            "**/.repo"
            "**/CVS"
            "**/.DS_Store"
            "**/Thumbs.db"
            "**/.classpath"
            "**/.settings"
            "**/.direnv"
            "**/result"
            "**/result-*"
          ];
          use_smartcase_search = true;

          # ── terminal: nushell, same colours as ghostty ────────────────────
          terminal = {
            shell.program = "${pkgs.nushell}/bin/nu";
            font_family = "Obel Mono";
            font_fallbacks = [ "JetBrainsMono Nerd Font" ];
            font_size = 13;
            cursor_shape = "block";
            blinking = "off";
            copy_on_select = true;
            max_scroll_history_lines = 20000;
            minimum_contrast = 0;
            toolbar.breadcrumbs = false;
          };

          # ── scm (git gutter only; jj drives the rest: home-zed-jujutsu) ───
          git = {
            git_gutter = "tracked_files";
            inline_blame.enabled = false;
          };

          # ── noise ─────────────────────────────────────────────────────────
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          auto_update = false; # nix owns the package
          session.trust_all_worktrees = true;
        };
      };
    };
}
