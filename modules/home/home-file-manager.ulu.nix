{ ... }:
{
  flake.homeModules.home-file-manager =
    { config, pkgs, ... }:
    let
      home = config.home.homeDirectory;
      thunar = pkgs.thunar.override {
        thunarPlugins = with pkgs; [
          thunar-media-tags-plugin
          thunar-archive-plugin
          thunar-vcs-plugin
          thunar-volman
        ];
      };
    in
    {
      home.packages = [ thunar ] ++ (with pkgs; [ catfish ]);
      xfconf.settings.thunar = {
        "default-view" = "ThunarIconsView";
        "last-view" = "ThunarIconsView";
        "last-icon-view-zoom-level" = "THUNAR_ZOOM_LEVEL_100_PERCENT";
        "last-details-view-zoom-level" = "THUNAR_ZOOM_LEVEL_38_PERCENT";
        "last-compact-view-zoom-level" = "THUNAR_ZOOM_LEVEL_50_PERCENT";
        "last-details-view-visible-columns" =
          "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED";
        "last-details-view-fixed-columns" = false;
        "misc-expandable-folders" = true;
        "misc-compact-view-max-chars" = 50;

        # UI
        "last-location-bar" = "ThunarLocationButtons";
        "last-side-pane" = "THUNAR_SIDEPANE_TYPE_SHORTCUTS";
        "last-menubar-visible" = false;
        "last-statusbar-visible" = true;
        "last-separator-position" = 180;
        "misc-use-csd" = true;
        "misc-small-toolbar-icons" = false;
        "misc-text-beside-icons" = false;
        "misc-symbolic-icons-in-toolbar" = true;
        "misc-symbolic-icons-in-sidepane" = true;
        "misc-window-title-style" = "THUNAR_WINDOW_TITLE_STYLE_FOLDER_NAME_WITHOUT_THUNAR_SUFFIX";
        "misc-change-window-icon" = true;
        "misc-highlighting-enabled" = true;
        "misc-status-bar-active-info" = {
          type = "uint";
          value = 61;
        };
        "misc-image-size-in-statusbar" = true;
        "last-toolbar-items" =
          "menu:0,back:1,forward:1,open-parent:1,open-home:1,"
          + "new-tab:0,new-window:0,toggle-split-view:1,"
          + "undo:1,redo:1,zoom-out:0,zoom-in:0,zoom-reset:0,"
          + "view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,view-switcher:1,"
          + "location-bar:1,reload:1,search:1";

        # SIDE PANE
        "shortcuts-icon-size" = "THUNAR_ICON_SIZE_16";
        "shortcuts-icon-emblems" = true;
        "tree-icon-size" = "THUNAR_ICON_SIZE_16";
        "tree-icon-emblems" = true;
        "misc-tree-lines-in-tree-sidepane" = true;

        # SORT
        "last-sort-column" = "THUNAR_COLUMN_NAME";
        "last-sort-order" = "GTK_SORT_ASCENDING";
        "misc-folders-first" = true;
        "misc-case-sensitive" = false;
        "last-show-hidden" = true;

        # TABS
        "last-restore-tabs" = true;
        "misc-open-new-window-as-tab" = true;
        "misc-switch-to-new-tab" = true;
        "misc-always-show-tabs" = false;
        "misc-tab-close-middle-click" = true;
        "misc-middle-click-in-tab" = true;
        "misc-confirm-close-multiple-tabs" = true;
        "misc-remember-geometry" = true;
        "misc-vertical-split-pane" = false;
        "misc-always-enable-split-view" = false;

        # THUMB
        "misc-thumbnail-mode" = "THUNAR_THUMBNAIL_MODE_ONLY_LOCAL";
        "misc-thumbnail-draw-frames" = true;
        "misc-thumbnail-max-file-size" = {
          type = "uint64";
          value = 0;
        };
        "misc-image-preview-mode" = "THUNAR_IMAGE_PREVIEW_MODE_EMBEDDED";
        "last-image-preview-visible" = false;
        "misc-folder-item-count" = "THUNAR_FOLDER_ITEM_COUNT_ONLY_LOCAL";

        # INTERACTION
        "misc-single-click" = false;
        "misc-ctrl-scroll-wheel-to-zoom" = true;
        "misc-horizontal-wheel-navigates" = true;
        "misc-date-style" = "THUNAR_DATE_STYLE_YYYYMMDD";
        "misc-file-size-binary" = true;
        "misc-recursive-search" = "THUNAR_RECURSIVE_SEARCH_LOCAL";
        "misc-show-about-templates" = false;
        "misc-directory-specific-settings" = false;

        # FILE OPERATIONS
        "misc-volume-management" = true;
        "misc-exec-shell-scripts-by-default" = "THUNAR_EXECUTE_SHELL_SCRIPT_ASK";
        "misc-recursive-permissions" = "THUNAR_RECURSIVE_PERMISSIONS_ASK";
        "misc-confirm-move-to-trash" = false;
        "misc-show-delete-action" = true;
        "misc-undo-redo-history-size" = 30;
        "misc-parallel-copy-mode" = "THUNAR_PARALLEL_COPY_MODE_ONLY_LOCAL_SAME_DEVICES";
        "misc-transfer-use-partial" = "THUNAR_USE_PARTIAL_MODE_REMOTE";
        "misc-transfer-verify-file" = "THUNAR_VERIFY_FILE_MODE_REMOTE";
      };

      xfconf.settings.thunar-volman = {
        "automount-drives/enabled" = true;
        "automount-media/enabled" = true;
        "autobrowse/enabled" = true;
        "autoopen/enabled" = false;
        "autorun/enabled" = false;
        "autoburn/enabled" = false;
        "autoplay-audio-cds/enabled" = false;
        "autoplay-video-cds/enabled" = false;
        "autophoto/enabled" = false;
        "autoipod/enabled" = false;
        "autokeyboard/enabled" = false;
        "automouse/enabled" = false;
        "autoprinter/enabled" = false;
        "autotablet/enabled" = false;
      };

      gtk.gtk3.bookmarks = [
        "file://${home}/copland nix"
        "file://${home}/.config dotfiles"
        "file://${home}/Documents"
        "file://${home}/Downloads"
        "file://${home}/Music"
        "file://${home}/Pictures"
        "file://${home}/Videos"
        "file://${home}/Videos-HDD"
        "file://${home}/Projects"
        "file://${home}/ProjectsHDD"
      ];
    };
}
