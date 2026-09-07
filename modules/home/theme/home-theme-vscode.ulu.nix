{ ... }:
{
  flake.homeModules.home-theme-vscode =
    { config, lib, ... }:
    # auto-generated
    let
      p = config.elars.theme.palette.withHashtag;
      vivid = 125;
      toHex =
        n:
        let
          digits = "0123456789abcdef";
          c =
            if n < 0 then
              0
            else if n > 255 then
              255
            else
              n;
        in
        builtins.substring (c / 16) 1 digits + builtins.substring (lib.mod c 16) 1 digits;
      lift =
        pct: hex: "#" + lib.concatMapStrings (c: toHex (c * pct / 100)) (config.elars.theme.hexToRgb hex);

      bg = p.base00;
      bgAlt = p.base01;
      bgSoft = p.base02;
      gutter = p.base03;
      gray = lift vivid p.base04;
      fg = p.base05;
      fgSoft = p.base06;
      fgBright = p.base07;
      red = lift vivid p.base08;
      orange = lift vivid p.base09;
      yellow = lift vivid p.base0A;
      green = lift vivid p.base0B;
      cyan = lift vivid p.base0C;
      blue = lift vivid p.base0D;
      magenta = lift vivid p.base0E;
      brown = lift 175 p.base0F;

      none = "#00000000";

      overlay = "${gutter}80";
      overlayStrong = "${gray}80";
      overlaySoft = "${bgSoft}80";

      sel = "${blue}66";
      selSoft = "${blue}33";
      selDim = "${blue}26";
      find = "${yellow}4d";
      findSoft = "${yellow}26";
      word = "${gray}33";
      wordStrong = "${gray}4d";

      rule = scopes: fg': {
        scope = scopes;
        settings.foreground = fg';
      };
      ruleStyled = scopes: fg': style: {
        scope = scopes;
        settings = {
          foreground = fg';
          fontStyle = style;
        };
      };
    in
    {
      programs.vscodium.profiles.default.userSettings = {
        "workbench.colorTheme" = "Default Dark Modern";

        "workbench.colorCustomizations" = {
          foreground = fg;
          descriptionForeground = gray;
          disabledForeground = gutter;
          errorForeground = red;
          focusBorder = gutter;
          contrastBorder = none;
          contrastActiveBorder = none;
          "widget.border" = bgSoft;
          "widget.shadow" = none;
          "selection.background" = bgSoft;
          "icon.foreground" = fgSoft;
          "sash.hoverBorder" = gutter;
          "textLink.foreground" = cyan;
          "textLink.activeForeground" = fgSoft;
          "textPreformat.foreground" = green;
          "toolbar.hoverBackground" = bgSoft;

          # editor — ui.background / ui.cursor / ui.selection / ui.linenr
          "editor.background" = bg;
          "editor.foreground" = fg;
          "editorLineNumber.foreground" = gutter;
          "editorLineNumber.activeForeground" = orange;
          "editorCursor.foreground" = fgBright;
          "editorCursor.background" = bg;
          "editor.lineHighlightBackground" = bgAlt;
          "editor.lineHighlightBorder" = none;
          "editor.selectionBackground" = sel;
          "editor.inactiveSelectionBackground" = selDim;
          "editor.selectionHighlightBackground" = selSoft;
          "editor.selectionHighlightBorder" = none;
          "editor.wordHighlightBackground" = word;
          "editor.wordHighlightStrongBackground" = wordStrong;
          "editor.findMatchBackground" = find;
          "editor.findMatchHighlightBackground" = findSoft;
          "editor.findMatchBorder" = orange;
          "editor.rangeHighlightBackground" = overlaySoft;
          "editor.foldBackground" = overlaySoft;
          "editorBracketMatch.background" = none;
          "editorBracketMatch.border" = orange;
          "editorIndentGuide.background1" = bgSoft;
          "editorIndentGuide.activeBackground1" = gutter;
          "editorRuler.foreground" = bgAlt;
          "editorWhitespace.foreground" = bgSoft;
          "editorInlayHint.foreground" = gray;
          "editorInlayHint.background" = none;
          "editorInlayHint.typeForeground" = gray;
          "editorInlayHint.parameterForeground" = gray;
          "editorCodeLens.foreground" = gray;
          "editorLink.activeForeground" = cyan;
          "editorOverviewRuler.border" = none;
          "editorGhostText.foreground" = gutter;
          "editorStickyScroll.background" = bg;

          # gutter / diff
          "editorGutter.background" = bg;
          "editorGutter.addedBackground" = green;
          "editorGutter.deletedBackground" = red;
          "editorGutter.modifiedBackground" = blue;
          "editorGutter.foldingControlForeground" = gutter;
          "diffEditor.insertedTextBackground" = "${green}1a";
          "diffEditor.removedTextBackground" = "${red}1a";
          "diffEditor.insertedLineBackground" = "${green}14";
          "diffEditor.removedLineBackground" = "${red}14";
          "diffEditor.border" = bgSoft;

          # diagnostics
          "editorError.foreground" = red;
          "editorWarning.foreground" = yellow;
          "editorInfo.foreground" = blue;
          "editorHint.foreground" = cyan;

          # chrome
          "titleBar.activeBackground" = bg;
          "titleBar.activeForeground" = fgSoft;
          "titleBar.inactiveBackground" = bg;
          "titleBar.inactiveForeground" = gray;
          "titleBar.border" = none;
          "sideBar.background" = bg;
          "sideBar.foreground" = fgSoft;
          "sideBar.border" = bgAlt;
          "sideBarSectionHeader.background" = bg;
          "sideBarSectionHeader.foreground" = gray;
          "sideBarSectionHeader.border" = none;
          "sideBarTitle.foreground" = gray;
          "activityBar.background" = bg;
          "activityBar.foreground" = fgSoft;
          "activityBar.inactiveForeground" = gutter;
          "activityBar.border" = none;
          "activityBarBadge.background" = fgSoft;
          "activityBarBadge.foreground" = bg;
          "panel.background" = bg;
          "panel.border" = bgAlt;
          "panelTitle.activeForeground" = fg;
          "panelTitle.inactiveForeground" = gray;
          "panelTitle.activeBorder" = fgSoft;
          "panelSection.border" = bgAlt;
          "editorGroupHeader.tabsBackground" = bg;
          "editorGroupHeader.tabsBorder" = bgAlt;
          "editorGroupHeader.noTabsBackground" = bg;
          "editorGroup.border" = bgAlt;
          "editorPane.background" = bg;

          # tabs — ui.bufferline
          "tab.activeBackground" = bgSoft;
          "tab.activeForeground" = fg;
          "tab.inactiveBackground" = bgAlt;
          "tab.inactiveForeground" = gray;
          "tab.unfocusedActiveBackground" = bgAlt;
          "tab.unfocusedActiveForeground" = gray;
          "tab.border" = bg;
          "tab.activeBorder" = none;
          "tab.activeBorderTop" = fgSoft;
          "tab.unfocusedActiveBorderTop" = gutter;
          "tab.hoverBackground" = bgSoft;
          "tab.activeModifiedBorder" = orange;
          "tab.inactiveModifiedBorder" = gutter;

          # statusline — ui.statusline
          "statusBar.background" = bgSoft;
          "statusBar.foreground" = fg;
          "statusBar.border" = none;
          "statusBar.noFolderBackground" = bgAlt;
          "statusBar.noFolderForeground" = gray;
          "statusBar.debuggingBackground" = orange;
          "statusBar.debuggingForeground" = bg;
          "statusBarItem.hoverBackground" = gutter;
          "statusBarItem.activeBackground" = gutter;
          "statusBarItem.prominentBackground" = gutter;
          "statusBarItem.remoteBackground" = blue;
          "statusBarItem.remoteForeground" = bg;
          "statusBarItem.errorBackground" = red;
          "statusBarItem.errorForeground" = bg;
          "statusBarItem.warningBackground" = yellow;
          "statusBarItem.warningForeground" = bg;

          # popups / pickers — ui.popup, ui.menu
          "editorWidget.background" = bgAlt;
          "editorWidget.foreground" = fg;
          "editorWidget.border" = bgSoft;
          "editorHoverWidget.background" = bgAlt;
          "editorHoverWidget.border" = bgSoft;
          "editorSuggestWidget.background" = bgAlt;
          "editorSuggestWidget.border" = bgSoft;
          "editorSuggestWidget.foreground" = fg;
          "editorSuggestWidget.selectedBackground" = gutter;
          "editorSuggestWidget.selectedForeground" = fgBright;
          "editorSuggestWidget.highlightForeground" = orange;
          "editorSuggestWidget.focusHighlightForeground" = orange;
          "peekView.border" = bgSoft;
          "peekViewEditor.background" = bgAlt;
          "peekViewEditor.matchHighlightBackground" = find;
          "peekViewResult.background" = bgAlt;
          "peekViewResult.selectionBackground" = gutter;
          "peekViewTitle.background" = bgAlt;
          "quickInput.background" = bgAlt;
          "quickInput.foreground" = fg;
          "quickInputList.focusBackground" = gutter;
          "quickInputList.focusForeground" = fgBright;
          "quickInputTitle.background" = bgAlt;
          "pickerGroup.border" = bgSoft;
          "pickerGroup.foreground" = gray;

          "list.activeSelectionBackground" = bgSoft;
          "list.activeSelectionForeground" = fg;
          "list.inactiveSelectionBackground" = bgAlt;
          "list.inactiveSelectionForeground" = fgSoft;
          "list.hoverBackground" = bgAlt;
          "list.focusBackground" = bgSoft;
          "list.focusOutline" = none;
          "list.highlightForeground" = orange;
          "list.errorForeground" = red;
          "list.warningForeground" = yellow;
          "tree.indentGuidesStroke" = bgAlt;

          "menu.background" = bgAlt;
          "menu.foreground" = fg;
          "menu.selectionBackground" = gutter;
          "menu.selectionForeground" = fgBright;
          "menu.border" = bgSoft;
          "menu.separatorBackground" = bgSoft;
          "menubar.selectionBackground" = bgSoft;

          "input.background" = bgAlt;
          "input.foreground" = fg;
          "input.border" = bgSoft;
          "input.placeholderForeground" = gray;
          "inputOption.activeBorder" = fgSoft;
          "inputOption.activeBackground" = bgSoft;
          "inputValidation.errorBackground" = bgAlt;
          "inputValidation.errorBorder" = red;
          "inputValidation.warningBackground" = bgAlt;
          "inputValidation.warningBorder" = yellow;
          "inputValidation.infoBackground" = bgAlt;
          "inputValidation.infoBorder" = blue;
          "dropdown.background" = bgAlt;
          "dropdown.foreground" = fg;
          "dropdown.border" = bgSoft;

          "button.background" = gutter;
          "button.foreground" = fg;
          "button.hoverBackground" = gray;
          "button.secondaryBackground" = bgSoft;
          "button.secondaryForeground" = fgSoft;
          "badge.background" = bgSoft;
          "badge.foreground" = fgSoft;
          "progressBar.background" = fgSoft;

          "scrollbar.shadow" = none;
          "scrollbarSlider.background" = "${bgSoft}80";
          "scrollbarSlider.hoverBackground" = gutter;
          "scrollbarSlider.activeBackground" = gray;

          "notifications.background" = bgAlt;
          "notifications.foreground" = fg;
          "notifications.border" = bgSoft;
          "notificationCenterHeader.background" = bgAlt;
          "notificationCenterHeader.foreground" = gray;
          "notificationsErrorIcon.foreground" = red;
          "notificationsWarningIcon.foreground" = yellow;
          "notificationsInfoIcon.foreground" = blue;

          # scm decorations
          "gitDecoration.addedResourceForeground" = green;
          "gitDecoration.modifiedResourceForeground" = blue;
          "gitDecoration.deletedResourceForeground" = red;
          "gitDecoration.untrackedResourceForeground" = green;
          "gitDecoration.ignoredResourceForeground" = gutter;
          "gitDecoration.conflictingResourceForeground" = orange;
          "gitDecoration.stageModifiedResourceForeground" = cyan;

          # terminal — same 16 as home-theme-ghostty
          "terminal.background" = bg;
          "terminal.foreground" = fg;
          "terminal.selectionBackground" = bgSoft;
          "terminal.border" = bgAlt;
          "terminalCursor.foreground" = p.accent;
          "terminalCursor.background" = bg;
          "terminal.ansiBlack" = bg;
          "terminal.ansiRed" = red;
          "terminal.ansiGreen" = green;
          "terminal.ansiYellow" = yellow;
          "terminal.ansiBlue" = blue;
          "terminal.ansiMagenta" = magenta;
          "terminal.ansiCyan" = cyan;
          "terminal.ansiWhite" = fg;
          "terminal.ansiBrightBlack" = gutter;
          "terminal.ansiBrightRed" = red;
          "terminal.ansiBrightGreen" = green;
          "terminal.ansiBrightYellow" = orange;
          "terminal.ansiBrightBlue" = blue;
          "terminal.ansiBrightMagenta" = magenta;
          "terminal.ansiBrightCyan" = cyan;
          "terminal.ansiBrightWhite" = fgBright;

          # dap — ui.debug
          "debugToolBar.background" = bgAlt;
          "debugIcon.breakpointForeground" = red;
          "editor.stackFrameHighlightBackground" = "${orange}33";

          "keybindingLabel.background" = bgSoft;
          "keybindingLabel.foreground" = fgSoft;
          "keybindingLabel.border" = bgSoft;
          "keybindingLabel.bottomBorder" = bgSoft;

          "charts.red" = red;
          "charts.orange" = orange;
          "charts.yellow" = yellow;
          "charts.green" = green;
          "charts.blue" = blue;
          "charts.purple" = magenta;
          "charts.foreground" = fg;
          "charts.lines" = bgSoft;
        };

        # syntax
        "editor.tokenColorCustomizations" = {
          comments = {
            foreground = gray;
            fontStyle = "italic";
          };
          textMateRules = [
            (ruleStyled [ "comment" "punctuation.definition.comment" ] gray "italic")
            (rule [ "variable" "meta.definition.variable.name" "support.variable" ] fg)
            (rule [ "variable.parameter" "meta.function.parameters" ] fgSoft)
            (rule [ "variable.language" "variable.other.builtin" "keyword.other.this" ] red)
            (rule [
              "variable.other.member"
              "variable.other.property"
              "meta.object-literal.key"
              "support.type.property-name"
            ] cyan)
            (rule [ "constant" "constant.language" "constant.other" "constant.numeric" ] orange)
            (rule [ "constant.character.escape" "constant.other.placeholder" ] magenta)
            (rule [ "string" "string.quoted" "punctuation.definition.string" ] green)
            (rule [ "string.regexp" "constant.regexp" ] cyan)
            (rule [
              "entity.name.type"
              "support.type"
              "storage.type"
              "entity.name.class"
              "entity.other.inherited-class"
              "support.type.primitive"
              "storage.type.primitive"
              "storage.type.built-in"
            ] yellow)
            (rule [ "entity.name.function.constructor" "meta.object.constructor" ] blue)
            (rule [ "entity.name.function" "support.function" "meta.function-call" ] blue)
            (rule [ "entity.name.function.macro" "support.function.macro" "meta.preprocessor.macro" ] magenta)
            (rule [ "keyword" "keyword.control" "keyword.operator.new" "storage.modifier" ] magenta)
            (rule [ "keyword.control.directive" "meta.preprocessor" "punctuation.definition.directive" ] brown)
            (rule [ "keyword.operator" "storage.type.function.arrow" ] fgSoft)
            (rule [ "punctuation" "punctuation.separator" "punctuation.terminator" "meta.delimiter" ] gray)
            (rule [
              "punctuation.section"
              "meta.brace"
              "punctuation.definition.block"
              "punctuation.definition.parameters"
            ] fgSoft)
            (rule [ "entity.name.label" "constant.other.label" ] magenta)
            (rule [ "entity.name.namespace" "entity.name.scope-resolution" "support.module" ] cyan)
            (rule [ "entity.other.attribute-name" "meta.attribute" "meta.decorator" ] brown)
            (rule [ "entity.name.tag" "punctuation.definition.tag" ] blue)
            (rule [ "invalid" "invalid.illegal" ] red)
            (ruleStyled [ "invalid.deprecated" ] yellow "strikethrough")
            (ruleStyled [ "markup.heading" "entity.name.section" ] orange "bold")
            (rule [ "punctuation.definition.heading" ] brown)
            {
              scope = [ "markup.bold" ];
              settings.fontStyle = "bold";
            }
            {
              scope = [ "markup.italic" ];
              settings.fontStyle = "italic";
            }
            {
              scope = [ "markup.strikethrough" ];
              settings.fontStyle = "strikethrough";
            }
            (ruleStyled [ "markup.underline.link" "string.other.link" ] cyan "underline")
            (rule [ "markup.inline.raw" "markup.fenced_code" "markup.raw" ] green)
            (rule [ "markup.list" "punctuation.definition.list.begin" ] magenta)
            (ruleStyled [ "markup.quote" ] fgSoft "italic")
            (rule [ "markup.inserted" "meta.diff.header.to-file" ] green)
            (rule [ "markup.deleted" "meta.diff.header.from-file" ] red)
            (rule [ "markup.changed" ] blue)
          ];
        };

        "editor.semanticTokenColorCustomizations" = {
          enabled = true;
          rules = {
            comment = {
              foreground = gray;
              fontStyle = "italic";
            };
            variable = fg;
            parameter = fgSoft;
            property = cyan;
            function = blue;
            method = blue;
            macro = magenta;
            type = yellow;
            struct = yellow;
            class = yellow;
            enum = yellow;
            union = yellow;
            interface = yellow;
            typeParameter = yellow;
            builtinType = yellow;
            enumMember = orange;
            namespace = cyan;
            keyword = magenta;
            selfKeyword = red;
            string = green;
            number = orange;
            boolean = orange;
            character = green;
            operator = fgSoft;
            lifetime = magenta;
            label = magenta;
            attribute = brown;
            attributeBracket = brown;
            "*.mutable".underline = true;
            "*.unsafe" = red;
            "*.deprecated".strikethrough = true;
            unresolvedReference = {
              foreground = red;
              underline = true;
            };
          };
        };

        "helixKeymap.yankHighlightBackgroundColor" = yellow;
        "better-comments.multilineComments" = true;
        "better-comments.highlightPlainText" = false;
        "better-comments.tags" = [
          {
            tag = "!";
            color = red;
            strikethrough = false;
            underline = false;
            backgroundColor = "transparent";
            bold = true;
            italic = true;
          }
          {
            tag = "?";
            color = cyan;
            strikethrough = false;
            underline = false;
            backgroundColor = "transparent";
            bold = false;
            italic = true;
          }
          {
            tag = "todo";
            color = orange;
            strikethrough = false;
            underline = false;
            backgroundColor = "transparent";
            bold = true;
            italic = true;
          }
          {
            tag = "*";
            color = green;
            strikethrough = false;
            underline = false;
            backgroundColor = "transparent";
            bold = false;
            italic = true;
          }
          {
            tag = "//";
            color = gutter;
            strikethrough = true;
            underline = false;
            backgroundColor = "transparent";
            bold = false;
            italic = true;
          }
        ];
      };
    };
}
