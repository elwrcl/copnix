{ ... }:
{
  flake.homeModules.home-obsidian =
    { ... }:
    {
      programs.obsidian = {
        enable = true;
        defaultSettings = {
          app = {
            promptDelete = false;
            alwaysUpdateLinks = true;
            newFileLocation = "current";
            attachmentFolderPath = "attachments";
            vimMode = false;
          };
          corePlugins = [
            "file-explorer"
            "global-search"
            "switcher"
            "graph"
            "backlink"
            "outgoing-link"
            "tag-pane"
            "page-preview"
            "daily-notes"
            "templates"
            "note-composer"
            "command-palette"
            "editor-status"
            "bookmarks"
            "outline"
            "word-count"
            "file-recovery"
          ];
        };
        vaults.notes.target = "Documents/Obsidian";
      };
    };
}
