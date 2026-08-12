{ ... }:
{
  flake.homeModules.home-file-manager-actions =
    { pkgs, lib, ... }:
    let
      inherit (lib)
        concatStringsSep
        concatMapStringsSep
        escapeXML
        optional
        ;
      fmActions = pkgs.writeShellApplication {
        name = "fm-actions";
        runtimeInputs = with pkgs; [
          poppler-utils
          wl-clipboard
          imagemagick
          libarchive
          coreutils
          libnotify
          tesseract
          ffmpeg
          gnutar
          p7zip
          zstd
          zip
        ];
        text = ''
          op="''${1:-}"
          if [ "$#" -gt 0 ]; then shift; fi

          notify() {
            notify-send -a Thunar -i system-file-manager "$1" "''${2:-}" || true
          }
          finish() {
            status=$?
            if [ -t 0 ]; then
              printf '\n[fm-actions] exit %s — press enter to close\n' "$status"
              read -r _ || true
            elif [ "$status" -ne 0 ]; then
              notify-send -a Thunar -u critical "action failed" \
                "fm-actions ''${op:-?} exited with $status" || true
            fi
          }
          trap finish EXIT
          stem() { printf '%s' "''${1%.*}"; }
          escape_own_folder() {
            if [ ! -e "$1" ] && [ "$(basename -- "$PWD")" = "$1" ]; then
              cd .. || exit 1
            fi
          }
          case "$op" in
            copy-path)
              printf '%s\n' "$@" | wl-copy
              notify "path copied" "$# item(s)"
              ;;
            copy-content)
              cat -- "$@" | wl-copy
              notify "contents copied" "$# file(s)"
              ;;
            duplicate)
              for f in "$@"; do cp -a -- "$f" "$f.copy"; done
              notify "duplicated" "$# item(s)"
              ;;
            symlink)
              for f in "$@"; do ln -s -- "$f" "$f.link"; done
              notify "symlinked" "$# item(s)"
              ;;
            checksum)
              sha256sum -- "$@"
              ;;
            img-png)
              for f in "$@"; do magick "$f" "$(stem "$f").png"; done
              notify "converted to png" "$# image(s)"
              ;;
            img-jpg)
              for f in "$@"; do magick "$f" -quality 92 "$(stem "$f").jpg"; done
              notify "converted to jpeg" "$# image(s)"
              ;;
            img-webp)
              for f in "$@"; do magick "$f" -quality 90 "$(stem "$f").webp"; done
              notify "converted to webp" "$# image(s)"
              ;;
            img-resize)
              for f in "$@"; do
                magick "$f" -resize '1920x1920>' "$(stem "$f")-1920.''${f##*.}"
              done
              notify "resized to 1920px" "$# image(s)"
              ;;
            img-strip)
              for f in "$@"; do magick "$f" -strip "$f"; done
              notify "metadata stripped" "$# image(s)"
              ;;
            ocr)
              tesseract "$1" - -l eng+tur 2>/dev/null | wl-copy
              notify "OCR" "recognised text copied to clipboard"
              ;;
            wallpaper)
              noctalia msg wallpaper-set "$1"
              ;;
            vid-mp4)
              for f in "$@"; do
                ffmpeg -nostdin -hide_banner -i "$f" \
                  -c:v libx264 -crf 20 -preset medium -c:a aac -b:a 192k \
                  "$(stem "$f").mp4"
              done
              ;;
            vid-audio)
              for f in "$@"; do
                ffmpeg -nostdin -hide_banner -i "$f" -vn -c:a libmp3lame -q:a 2 \
                  "$(stem "$f").mp3"
              done
              ;;
            vid-gif)
              for f in "$@"; do
                palette="$(mktemp --suffix=.png)"
                ffmpeg -nostdin -hide_banner -y -i "$f" \
                  -vf 'fps=15,scale=640:-1:flags=lanczos,palettegen' "$palette"
                ffmpeg -nostdin -hide_banner -y -i "$f" -i "$palette" \
                  -lavfi 'fps=15,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse' \
                  "$(stem "$f").gif"
                rm -f "$palette"
              done
              ;;
            media-info)
              for f in "$@"; do
                printf '\n=== %s ===\n' "$f"
                ffprobe -hide_banner "$f" 2>&1 || true
              done
              ;;

            zip)
              escape_own_folder "$1"
              zip -r -- "$1.zip" "$@"
              notify "archive created" "$1.zip"
              ;;
            7z)
              escape_own_folder "$1"
              7z a -- "$1.7z" "$@"
              notify "archive created" "$1.7z"
              ;;
            tar-zst)
              escape_own_folder "$1"
              tar --zstd -cf "$1.tar.zst" -- "$@"
              notify "archive created" "$1.tar.zst"
              ;;
            extract)
              for f in "$@"; do bsdtar -xf "$f"; done
              notify "extracted" "$# archive(s)"
              ;;
            extract-to-folder)
              for f in "$@"; do
                d="$(stem "$f")"
                mkdir -p "$d"
                bsdtar -xf "$f" -C "$d"
              done
              notify "extracted into folders" "$# archive(s)"
              ;;

            pdf-images)
              for f in "$@"; do pdftoppm -png -r 150 "$f" "$(stem "$f")"; done
              notify "PDF rendered" "$# document(s)"
              ;;
            pdf-merge)
              pdfunite "$@" merged.pdf
              notify "PDFs merged" "merged.pdf"
              ;;

            *)
              echo "fm-actions: unknown operation: $op" >&2
              exit 2
              ;;
          esac
        '';
      };

      fm = lib.getExe fmActions;
      term = "ghostty --working-directory=%f";
      dirs = [ "directories" ];
      files = [
        "audio-files"
        "image-files"
        "other-files"
        "text-files"
        "video-files"
      ];
      everything = dirs ++ files;
      archivePatterns = [
        "*.7z"
        "*.bz2"
        "*.cab"
        "*.gz"
        "*.iso"
        "*.rar"
        "*.tar"
        "*.tar.bz2"
        "*.tar.gz"
        "*.tar.xz"
        "*.tar.zst"
        "*.tbz2"
        "*.tgz"
        "*.txz"
        "*.xz"
        "*.zip"
        "*.zst"
      ];

      mkAction =
        {
          id,
          name,
          command,
          icon ? "",
          description ? "",
          patterns ? [ "*" ],
          types ? [ ],
          submenu ? null,
          range ? null,
          startupNotify ? true,
        }:
        concatStringsSep "\n" (
          [ "  <action>" ]
          ++ map (line: "    " + line) (
            [
              "<icon>${escapeXML icon}</icon>"
              "<name>${escapeXML name}</name>"
              "<unique-id>${escapeXML id}</unique-id>"
              "<command>${escapeXML command}</command>"
              "<description>${escapeXML description}</description>"
              "<patterns>${escapeXML (concatStringsSep ";" patterns)}</patterns>"
            ]
            ++ optional (submenu != null) "<submenu>${escapeXML submenu}</submenu>"
            ++ optional (range != null) "<range>${escapeXML range}</range>"
            ++ optional startupNotify "<startup-notify/>"
            ++ map (t: "<${t}/>") types
          )
          ++ [ "  </action>" ]
        );

      # this is slop but idc.
      actions = [
        {
          id = "open-terminal-here";
          name = "Open Terminal Here";
          description = "browse folder in ghostty";
          icon = "utilities-terminal";
          command = term;
          types = dirs;
        }
        {
          id = "open-root-terminal-here";
          name = "Open Root Terminal Here";
          description = "browse folder in ghostty as root";
          icon = "dialog-password";
          command = "${term} -e sudo -E -s";
          types = dirs;
        }
        {
          id = "open-yazi-here";
          name = "Open Yazi Here";
          description = "browse folder in yazi";
          icon = "system-file-manager";
          command = "${term} -e yazi";
          types = dirs;
        }
        {
          id = "open-as-root";
          name = "Open as Root";
          description = "reopen folder as root";
          icon = "security-high";
          command = "thunar admin://%f";
          types = dirs;
        }
        {
          id = "open-in-code";
          name = "Open in VS Code";
          description = "open in vsc";
          icon = "applications-development";
          command = "code %F";
          types = everything;
        }
        {
          id = "search-here";
          name = "Search Here";
          description = "search in this folder with catfish";
          icon = "system-search";
          command = "catfish --path=%f";
          types = dirs;
        }
        {
          id = "open-lazyjj-here";
          name = "Open lazyjj Here";
          description = "inspect with lazyjj";
          icon = "folder-open";
          command = "${term} -e lazyjj";
          types = dirs;
        }
        {
          id = "open-lazygit-here";
          name = "Open lazygit Here";
          description = "inspect with lazygit";
          icon = "folder-open";
          command = "${term} -e lazygit";
          types = dirs;
        }
        {
          id = "play-in-mpv";
          name = "Play in mpv";
          description = "play with mpv";
          icon = "multimedia-player";
          command = "mpv -- %F";
          types = [
            "audio-files"
            "video-files"
          ];
        }
        {
          id = "compare-in-meld";
          name = "Compare in Meld";
          description = "diff exactly two files or folders";
          icon = "document-properties";
          command = "meld %F";
          range = "2-2";
          types = everything;
        }
        {
          id = "archive-extract-here";
          name = "Extract Here";
          description = "unpack content into the current folder";
          icon = "package-x-generic";
          command = "${fm} extract %F";
          patterns = archivePatterns;
          submenu = "Archive";
          types = [ "other-files" ];
        }
        {
          id = "archive-extract-to-folder";
          name = "Extract to Folder";
          description = "unpack into a folder named after the archive";
          icon = "package-x-generic";
          command = "${fm} extract-to-folder %F";
          patterns = archivePatterns;
          submenu = "Archive";
          types = [ "other-files" ];
        }
        {
          id = "archive-zip";
          name = "Compress to .zip";
          icon = "package-x-generic";
          command = "${fm} zip %N";
          submenu = "Archive";
          types = everything;
        }
        {
          id = "archive-7z";
          name = "Compress to .7z";
          icon = "package-x-generic";
          command = "${fm} 7z %N";
          submenu = "Archive";
          types = everything;
        }
        {
          id = "archive-tar-zst";
          name = "Compress to .tar.zst";
          icon = "package-x-generic";
          command = "${fm} tar-zst %N";
          submenu = "Archive";
          types = everything;
        }
        {
          id = "image-to-png";
          name = "Convert to PNG";
          icon = "image-x-generic";
          command = "${fm} img-png %F";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "image-to-jpg";
          name = "Convert to JPEG";
          icon = "image-x-generic";
          command = "${fm} img-jpg %F";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "image-to-webp";
          name = "Convert to WebP";
          icon = "image-x-generic";
          command = "${fm} img-webp %F";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "image-resize-1920";
          name = "Resize to 1920px";
          description = "shrink to 1920px wide but keep aspect ratio";
          icon = "image-x-generic";
          command = "${fm} img-resize %F";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "image-strip-metadata";
          name = "Strip Metadata";
          description = "remove EXIF and other metadata from images";
          icon = "image-x-generic";
          command = "${fm} img-strip %F";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "image-ocr";
          name = "OCR to Clipboard";
          description = "ocr to clipboard";
          icon = "edit-copy";
          command = "${fm} ocr %f";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "image-set-wallpaper";
          name = "Set as Wallpaper";
          icon = "preferences-desktop-wallpaper";
          command = "${fm} wallpaper %f";
          submenu = "Image";
          types = [ "image-files" ];
        }
        {
          id = "media-to-mp4";
          name = "Convert to MP4";
          description = "H.264 / AAC, CRF 20";
          icon = "video-x-generic";
          command = "ghostty -e ${fm} vid-mp4 %F";
          submenu = "Media";
          types = [ "video-files" ];
        }
        {
          id = "media-extract-audio";
          name = "Extract Audio (MP3)";
          icon = "audio-x-generic";
          command = "ghostty -e ${fm} vid-audio %F";
          submenu = "Media";
          types = [
            "audio-files"
            "video-files"
          ];
        }
        {
          id = "media-to-gif";
          name = "Make GIF";
          description = "640px, 15 fps, optimized";
          icon = "video-x-generic";
          command = "ghostty -e ${fm} vid-gif %F";
          submenu = "Media";
          types = [ "video-files" ];
        }
        {
          id = "media-info";
          name = "Media Info";
          description = "ffprobe the selection";
          icon = "dialog-information";
          command = "ghostty -e ${fm} media-info %F";
          submenu = "Media";
          types = [
            "audio-files"
            "image-files"
            "video-files"
          ];
        }
        {
          id = "pdf-to-images";
          name = "Render to PNG";
          description = "150 dpi, one file per page";
          icon = "application-pdf";
          command = "${fm} pdf-images %F";
          patterns = [ "*.pdf" ];
          submenu = "PDF";
          types = [ "other-files" ];
        }
        {
          id = "pdf-merge";
          name = "Merge into merged.pdf";
          icon = "application-pdf";
          command = "${fm} pdf-merge %F";
          patterns = [ "*.pdf" ];
          range = "2-64";
          submenu = "PDF";
          types = [ "other-files" ];
        }
        {
          id = "tools-copy-path";
          name = "Copy Full Path";
          icon = "edit-copy";
          command = "${fm} copy-path %F";
          submenu = "Tools";
          types = everything;
        }
        {
          id = "tools-copy-content";
          name = "Copy File Contents";
          icon = "edit-copy";
          command = "${fm} copy-content %F";
          submenu = "Tools";
          types = [ "text-files" ];
        }
        {
          id = "tools-checksum";
          name = "SHA-256 Checksum";
          icon = "dialog-information";
          command = "ghostty -e ${fm} checksum %F";
          submenu = "Tools";
          types = files;
        }
        {
          id = "tools-duplicate";
          name = "Duplicate";
          description = "copy alongside as <name>.copy";
          icon = "edit-copy";
          command = "${fm} duplicate %F";
          submenu = "Tools";
          types = everything;
        }
        {
          id = "tools-symlink";
          name = "Create Symlink Here";
          icon = "emblem-symbolic-link";
          command = "${fm} symlink %F";
          submenu = "Tools";
          types = everything;
        }
        {
          id = "tools-dos2unix";
          name = "Fix Line Endings";
          description = "convert CRLF to LF";
          icon = "text-x-generic";
          command = "dos2unix -- %F";
          submenu = "Tools";
          types = [ "text-files" ];
        }
      ];
    in
    {
      home.packages = [ fmActions ];

      xdg.configFile."Thunar/uca.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <actions>
        ${concatMapStringsSep "\n" mkAction actions}
        </actions>
      '';
    };
}
