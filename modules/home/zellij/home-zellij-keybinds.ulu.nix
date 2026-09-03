{ ... }:
{
  flake.homeModules.home-zellij-keybinds =
    { ... }:
    {
      programs.zellij.extraConfig = ''
        keybinds clear-defaults=true {
            normal {
                bind "Ctrl g" { SwitchToMode "Tmux"; }

                // workbench, no prefix: Alt is zellij's layer
                bind "Alt Space" { ToggleFloatingPanes; }
                bind "Alt g" {
                    Run "lazyjj" {
                        floating true
                        close_on_exit true
                        name "source control"
                    }
                }

                // tabs
                bind "Alt t" { NewTab; }
                bind "Alt 1" { GoToTab 1; }
                bind "Alt 2" { GoToTab 2; }
                bind "Alt 3" { GoToTab 3; }
                bind "Alt 4" { GoToTab 4; }
                bind "Alt 5" { GoToTab 5; }
                bind "Alt 6" { GoToTab 6; }
                bind "Alt 7" { GoToTab 7; }
                bind "Alt 8" { GoToTab 8; }
                bind "Alt 9" { GoToTab 9; }
            }

            locked {
                bind "Ctrl g" { SwitchToMode "Normal"; }
            }

            tmux {
                bind "Ctrl g" { Write 7; SwitchToMode "Normal"; }

                // panes
                bind "-" "\"" { NewPane "Down"; SwitchToMode "Normal"; }
                bind "\\" "%" { NewPane "Right"; SwitchToMode "Normal"; }
                bind "n" { NewPane; SwitchToMode "Normal"; }
                bind "x" { CloseFocus; SwitchToMode "Normal"; }
                bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
                bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
                bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
                bind "i" { TogglePanePinned; SwitchToMode "Normal"; }
                bind "Space" { NextSwapLayout; SwitchToMode "Normal"; }

                // focus
                bind "h" "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
                bind "j" "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
                bind "k" "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
                bind "l" "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
                bind "o" { FocusNextPane; SwitchToMode "Normal"; }

                // moving panes around
                bind "H" { MovePane "Left"; SwitchToMode "Normal"; }
                bind "J" { MovePane "Down"; SwitchToMode "Normal"; }
                bind "K" { MovePane "Up"; SwitchToMode "Normal"; }
                bind "L" { MovePane "Right"; SwitchToMode "Normal"; }

                // tabs
                bind "c" { NewTab; SwitchToMode "Normal"; }
                bind "," { SwitchToMode "RenameTab"; TabNameInput 0; }
                bind "X" { CloseTab; SwitchToMode "Normal"; }
                bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
                bind "b" { BreakPane; SwitchToMode "Normal"; }
                bind "Tab" { ToggleTab; SwitchToMode "Normal"; }
                bind "1" { GoToTab 1; SwitchToMode "Normal"; }
                bind "2" { GoToTab 2; SwitchToMode "Normal"; }
                bind "3" { GoToTab 3; SwitchToMode "Normal"; }
                bind "4" { GoToTab 4; SwitchToMode "Normal"; }
                bind "5" { GoToTab 5; SwitchToMode "Normal"; }
                bind "6" { GoToTab 6; SwitchToMode "Normal"; }
                bind "7" { GoToTab 7; SwitchToMode "Normal"; }
                bind "8" { GoToTab 8; SwitchToMode "Normal"; }
                bind "9" { GoToTab 9; SwitchToMode "Normal"; }

                // sub-modes
                bind "r" { SwitchToMode "Resize"; }
                bind "[" { SwitchToMode "Scroll"; }
                bind "/" { SwitchToMode "EnterSearch"; SearchInput 0; }

                // tools
                bind "g" {
                    Run "lazyjj" {
                        floating true
                        close_on_exit true
                        name "lazyjj"
                    }
                    SwitchToMode "Normal"
                }
                bind "G" {
                    Run "lazygit" {
                        floating true
                        close_on_exit true
                        name "lazygit"
                    }
                    SwitchToMode "Normal"
                }
                bind "t" {
                    Run "nu" {
                        floating true
                        close_on_exit true
                        name "shell"
                    }
                    SwitchToMode "Normal"
                }
                bind "y" {
                    Run "yazi" {
                        floating true
                        close_on_exit true
                        name "files"
                    }
                    SwitchToMode "Normal"
                }
                bind "f" {
                    LaunchOrFocusPlugin "filepicker" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "Normal"
                }
                bind "s" {
                    LaunchOrFocusPlugin "session-manager" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "Normal"
                }

                // session
                bind "d" { Detach; }
                bind "Q" { Quit; }
            }

            resize {
                bind "h" "Left" { Resize "Increase Left"; }
                bind "j" "Down" { Resize "Increase Down"; }
                bind "k" "Up" { Resize "Increase Up"; }
                bind "l" "Right" { Resize "Increase Right"; }
                bind "H" { Resize "Decrease Left"; }
                bind "J" { Resize "Decrease Down"; }
                bind "K" { Resize "Decrease Up"; }
                bind "L" { Resize "Decrease Right"; }
                bind "=" "+" { Resize "Increase"; }
                bind "-" { Resize "Decrease"; }
            }

            scroll {
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "Ctrl f" "PageDown" { PageScrollDown; }
                bind "Ctrl b" "PageUp" { PageScrollUp; }
                bind "G" { ScrollToBottom; SwitchToMode "Normal"; }
                bind "e" { EditScrollback; SwitchToMode "Normal"; }
                bind "/" { SwitchToMode "EnterSearch"; SearchInput 0; }
            }

            search {
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "n" { Search "down"; }
                bind "p" { Search "up"; }
                bind "c" { SearchToggleOption "CaseSensitivity"; }
                bind "w" { SearchToggleOption "Wrap"; }
                bind "o" { SearchToggleOption "WholeWord"; }
            }

            entersearch {
                bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
                bind "Enter" { SwitchToMode "Search"; }
            }

            renametab {
                bind "Ctrl c" { SwitchToMode "Normal"; }
                bind "Esc" { UndoRenameTab; SwitchToMode "Normal"; }
            }

            renamepane {
                bind "Ctrl c" { SwitchToMode "Normal"; }
                bind "Esc" { UndoRenamePane; SwitchToMode "Normal"; }
            }

            shared_except "normal" "locked" "entersearch" "renametab" "renamepane" {
                bind "Enter" "Esc" { SwitchToMode "Normal"; }
            }
        }
      '';
    };
}
