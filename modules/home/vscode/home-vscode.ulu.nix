{ ... }:
{
  # auto-generated
  flake.homeModules.home-vscode =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      settingsPath = "${config.xdg.configHome}/VSCodium/User/settings.json";
    in
    {
      home.file.${settingsPath}.enable = false;

      home.activation.vscodiumWritableSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        _target="${settingsPath}"
        run mkdir -p "$(dirname "$_target")"
        # Önce sil: hedef store'a symlink'se install onu takip edip
        # salt-okunur dosyaya yazmaya çalışır.
        run rm -f "$_target"
        run install -m 0644 ${config.home.file.${settingsPath}.source} "$_target"
      '';

      programs.vscodium = {
        enable = true;
        mutableExtensionsDir = false;

        profiles.default.userSettings = {
          # ── editor: helix parity ──────────────────────────────────────────
          "editor.lineNumbers" = "relative";
          "editor.cursorSurroundingLines" = 8; # = scrolloff
          "editor.cursorBlinking" = "solid";
          "editor.cursorSmoothCaretAnimation" = "explicit";
          "editor.cursorStyle" = "block"; # per-mode override by the extension
          "editor.rulers" = [
            80
            100
          ];
          "editor.wordWrap" = "on"; # = soft-wrap.enable
          "editor.wrappingIndent" = "indent";
          "editor.renderLineHighlight" = "all"; # = cursorline
          "editor.guides.indentation" = true; # = indent-guides.render
          "editor.guides.bracketPairs" = false;
          "editor.bracketPairColorization.enabled" = false;
          "editor.matchBrackets" = "always";
          "editor.renderWhitespace" = "none";
          "editor.renderControlCharacters" = true;
          "editor.stickyScroll.enabled" = false;
          "editor.occurrencesHighlight" = "singleFile";
          "editor.selectionHighlight" = true;
          "editor.emptySelectionClipboard" = false;
          "editor.find.seedSearchStringFromSelection" = "never";
          "editor.multiCursorModifier" = "alt";
          "editor.dragAndDrop" = false;
          "editor.linkedEditing" = true;
          "editor.foldingHighlight" = false;
          "editor.overviewRulerBorder" = false;
          "editor.hideCursorInOverviewRuler" = true;
          "editor.scrollBeyondLastLine" = false;
          "editor.smoothScrolling" = true;
          "editor.formatOnSave" = true;

          # completion: enter inserts a newline, ctrl+x accepts
          "editor.acceptSuggestionOnEnter" = "off";
          "editor.acceptSuggestionOnCommitCharacter" = false;
          "editor.suggestSelection" = "first";
          "editor.suggest.insertMode" = "replace"; # = completion-replace
          "editor.suggest.preview" = true; # = preview-completion-insert
          "editor.suggest.showStatusBar" = true;
          "editor.snippetSuggestions" = "bottom";
          "editor.quickSuggestionsDelay" = 50; # = idle-timeout
          "editor.hover.delay" = 50;
          "editor.inlayHints.enabled" = "on";
          "editor.inlayHints.padding" = true;
          "editor.parameterHints.enabled" = true;
          "editor.wordBasedSuggestions" = "off";

          # ── typography ────────────────────────────────────────────────────
          "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'JetBrainsMono Nerd Font', monospace";
          "editor.fontWeight" = "500";
          "editor.fontLigatures" = false;
          "editor.lineHeight" = 1.6;
          "workbench.fontAliasing" = "antialiased";
          "chat.editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', monospace";
          "debug.console.fontFamily" = "'JetBrainsMono Nerd Font Mono', monospace";
          "markdown.preview.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
          "scm.inputFontFamily" = "'JetBrainsMono Nerd Font Mono', monospace";

          # ── chrome: editor + bufferline + statusline, nothing else ────────
          "workbench.iconTheme" = "symbols";
          "workbench.activityBar.location" = "hidden";
          "workbench.layoutControl.enabled" = false;
          "workbench.navigationControl.enabled" = false;
          "workbench.startupEditor" = "none";
          "workbench.tips.enabled" = false;
          "workbench.enableExperiments" = false;
          "workbench.tree.indent" = 16;
          "workbench.tree.renderIndentGuides" = "none";
          "workbench.list.smoothScrolling" = true;
          "workbench.browser.showInTitleBar" = false;
          "workbench.view.showQuietly"."workbench.panel.output" = false;
          "workbench.editor.showTabs" = "multiple"; # = bufferline "multiple"
          "workbench.editor.tabActionCloseVisibility" = false;
          "workbench.editor.tabSizing" = "shrink";
          "workbench.editor.editorActionsLocation" = "hidden";
          "workbench.editor.decorations.badges" = true;
          "workbench.editor.decorations.colors" = true;
          "workbench.editor.limit.enabled" = true;
          "workbench.editor.limit.value" = 12;
          "workbench.editor.limit.perEditorGroup" = true;
          "editor.minimap.enabled" = false;
          "editor.scrollbar.vertical" = "hidden";
          "editor.scrollbar.horizontal" = "hidden";
          "editor.scrollbar.verticalScrollbarSize" = 0;
          "breadcrumbs.enabled" = false;
          "window.commandCenter" = false;
          "window.titleBarStyle" = "custom";
          "window.menuStyle" = "custom";
          "window.controlsStyle" = "hidden";
          "window.customTitleBarVisibility" = "windowed";
          "window.title" = "\${rootName}\${separator}\${activeEditorMedium}\${separator}\${dirty}";
          "chat.titleBar.openInAgentsWindow.enabled" = false;
          "explorer.decorations.badges" = true;
          "explorer.decorations.colors" = true;
          "explorer.compactFolders" = false;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.fileNesting.enabled" = true;
          "explorer.fileNesting.patterns" = {
            "flake.nix" = "flake.lock";
            "Cargo.toml" = "Cargo.lock, rust-toolchain.toml, rustfmt.toml, clippy.toml";
          };
          "outline.showVariables" = false;

          # ── files ─────────────────────────────────────────────────────────
          "files.autoSave" = "onFocusChange"; # = auto-save.focus-lost
          "files.eol" = "\n";
          "files.trimTrailingWhitespace" = true;
          "files.trimFinalNewlines" = true;
          "files.insertFinalNewline" = true;
          "files.exclude" = {
            "**/.direnv" = true;
            "**/.jj" = true;
            "**/result" = true;
            "**/result-*" = true;
          };
          "files.watcherExclude" = {
            "**/.direnv/**" = true;
            "**/.git/**" = true;
            "**/.jj/**" = true;
            "**/build/**" = true;
            "**/dist/**" = true;
            "**/node_modules/**" = true;
            "**/target/**" = true;
          };
          "search.exclude" = {
            "**/.direnv" = true;
            "**/.jj" = true;
            "**/dist" = true;
            "**/node_modules" = true;
            "**/result" = true;
            "**/result-*" = true;
            "**/target" = true;
          };
          "search.useIgnoreFiles" = true;
          "search.smartCase" = true;
          "search.followSymlinks" = false;

          # ── terminal: nushell, same colours as ghostty ────────────────────
          "terminal.integrated.defaultProfile.osx" = "nu";
          "terminal.integrated.defaultProfile.linux" = "nu";
          "terminal.integrated.profiles.osx".nu.path = "${pkgs.nushell}/bin/nu";
          "terminal.integrated.profiles.linux".nu.path = "${pkgs.nushell}/bin/nu";
          "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
          "terminal.integrated.fontSize" = 13;
          "terminal.integrated.cursorStyle" = "block";
          "terminal.integrated.cursorBlinking" = false;
          "terminal.integrated.copyOnSelection" = true;
          "terminal.integrated.scrollback" = 20000;
          "terminal.integrated.minimumContrastRatio" = 1;
          "terminal.integrated.gpuAcceleration" = "on";
          "terminal.integrated.smoothScrolling" = true;
          "terminal.integrated.tabs.enabled" = false;
          "terminal.integrated.shellIntegration.decorationsEnabled" = "never";
          "terminal.integrated.enableVisualBell" = false;

          # ── scm (jj colocated: the git view reads the git side) ───────────
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "git.autofetch" = false;
          "git.openRepositoryInParentFolders" = "never";
          "git.decorations.enabled" = true;
          "scm.defaultViewMode" = "list";
          "scm.diffDecorations" = "gutter";
          "diffEditor.ignoreTrimWhitespace" = false;
          "diffEditor.renderSideBySide" = true;

          # ── noise ─────────────────────────────────────────────────────────
          "telemetry.telemetryLevel" = "off";
          "extensions.autoUpdate" = "off"; # nix owns the extension set
          "extensions.autoCheckUpdates" = false;
          "extensions.ignoreRecommendations" = true;
          "update.mode" = "none";
          "update.showReleaseNotes" = false;
          "security.workspace.trust.banner" = "never";
          "security.workspace.trust.untrustedFiles" = "open";
          "makefile.configureOnOpen" = false;
        };
      };
    };
}
