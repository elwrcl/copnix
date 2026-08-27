{ ... }:
{
  flake.homeModules.home-file-manager-actions =
    { pkgs, lib, ... }:
    let
      inherit (lib) concatStringsSep concatMap optional;

      fmActions = pkgs.writeShellApplication {
        name = "fm-actions";
        runtimeInputs = with pkgs; [
          poppler-utils
          wl-clipboard
          imagemagick
          coreutils
          libnotify
          tesseract
          ffmpeg
        ];
        text = ''
          op="''${1:-}"
          if [ "$#" -gt 0 ]; then shift; fi

          notify() {
            notify-send -a Dolphin -i system-file-manager "$1" "''${2:-}" || true
          }
          finish() {
            status=$?
            if [ -t 0 ]; then
              printf '\n[fm-actions] exit %s — press enter to close\n' "$status"
              read -r _ || true
            elif [ "$status" -ne 0 ]; then
              notify-send -a Dolphin -u critical "action failed" \
                "fm-actions ''${op:-?} exited with $status" || true
            fi
          }
          trap finish EXIT
          stem() { printf '%s' "''${1%.*}"; }
          require_count() {
            n="$1"; shift
            if [ "$#" -ne "$n" ]; then
              notify-send -a Dolphin -u critical "action failed" \
                "expected $n item(s), got $#" || true
              exit 2
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

            pdf-images)
              for f in "$@"; do pdftoppm -png -r 150 "$f" "$(stem "$f")"; done
              notify "PDF rendered" "$# document(s)"
              ;;
            pdf-merge)
              require_count 2 "$@" 2>/dev/null || true
              pdfunite "$@" merged.pdf
              notify "PDFs merged" "merged.pdf"
              ;;
            compare)
              require_count 2 "$@"
              meld "$@"
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
      typeMime = {
        directories = [ "inode/directory" ];
        everything = [ "all/all" ];
        files = [ "all/allfiles" ];
        audio-files = [ "audio/*" ];
        image-files = [ "image/*" ];
        video-files = [ "video/*" ];
        text-files = [ "text/*" ];
      };
      pdfMimeTypes = [ "application/pdf" ];
      actions = [
        {
          id = "open-terminal-here";
          name = "open ghostty here";
          icon = "utilities-terminal";
          command = term;
          types = [ "directories" ];
        }
        {
          id = "open-root-terminal-here";
          name = "open root terminal here";
          icon = "dialog-password";
          command = "${term} -e sudo -E -s";
          types = [ "directories" ];
        }
        {
          id = "open-yazi-here";
          name = "open yazi here";
          icon = "system-file-manager";
          command = "${term} -e yazi";
          types = [ "directories" ];
        }
        {
          id = "open-as-root";
          name = "open as root";
          icon = "security-high";
          command = "dolphin admin://%f";
          types = [ "directories" ];
        }
        {
          id = "open-lazyjj-here";
          name = "open lazyjj here";
          icon = "folder-open";
          command = "${term} -e lazyjj";
          types = [ "directories" ];
        }
        {
          id = "open-lazygit-here";
          name = "open lazygit here";
          icon = "folder-open";
          command = "${term} -e lazygit";
          types = [ "directories" ];
        }
        {
          id = "compare-in-meld";
          name = "compare in meld";
          icon = "document-properties";
          command = "${fm} compare %F";
          types = [ "everything" ];
        }
        {
          id = "image-to-png";
          name = "convert to PNG";
          icon = "image-x-generic";
          command = "${fm} img-png %F";
          types = [ "image-files" ];
          submenu = "Image";
        }
        {
          id = "image-to-jpg";
          name = "convert to JPEG";
          icon = "image-x-generic";
          command = "${fm} img-jpg %F";
          types = [ "image-files" ];
          submenu = "Image";
        }
        {
          id = "image-to-webp";
          name = "convert to WebP";
          icon = "image-x-generic";
          command = "${fm} img-webp %F";
          types = [ "image-files" ];
          submenu = "Image";
        }
        {
          id = "image-resize-1920";
          name = "resize to 1920px";
          icon = "image-x-generic";
          command = "${fm} img-resize %F";
          types = [ "image-files" ];
          submenu = "Image";
        }
        {
          id = "image-strip-metadata";
          name = "strip metadata";
          icon = "image-x-generic";
          command = "${fm} img-strip %F";
          types = [ "image-files" ];
          submenu = "Image";
        }
        {
          id = "image-set-wallpaper";
          name = "Set as Wallpaper";
          icon = "preferences-desktop-wallpaper";
          command = "${fm} wallpaper %f";
          types = [ "image-files" ];
          submenu = "Image";
        }
        {
          id = "media-to-mp4";
          name = "convert to MP4";
          icon = "video-x-generic";
          command = "ghostty -e ${fm} vid-mp4 %F";
          types = [ "video-files" ];
          submenu = "Media";
        }
        {
          id = "media-extract-audio";
          name = "extract Audio (MP3)";
          icon = "audio-x-generic";
          command = "ghostty -e ${fm} vid-audio %F";
          types = [
            "audio-files"
            "video-files"
          ];
          submenu = "Media";
        }
        {
          id = "media-to-gif";
          name = "make GIF";
          icon = "video-x-generic";
          command = "ghostty -e ${fm} vid-gif %F";
          types = [ "video-files" ];
          submenu = "Media";
        }
        {
          id = "media-info";
          name = "media info";
          icon = "dialog-information";
          command = "ghostty -e ${fm} media-info %F";
          types = [
            "audio-files"
            "image-files"
            "video-files"
          ];
          submenu = "Media";
        }
        {
          id = "pdf-to-images";
          name = "render to PNG";
          icon = "application-pdf";
          command = "${fm} pdf-images %F";
          mimeTypes = pdfMimeTypes;
          submenu = "PDF";
        }
        {
          id = "pdf-merge";
          name = "merge into merged.pdf";
          icon = "application-pdf";
          command = "${fm} pdf-merge %F";
          mimeTypes = pdfMimeTypes;
          submenu = "PDF";
        }
        {
          id = "tools-copy-path";
          name = "copy full path";
          icon = "edit-copy";
          command = "${fm} copy-path %F";
          types = [ "everything" ];
          submenu = "Tools";
        }
        {
          id = "tools-copy-content";
          name = "copy file contents";
          icon = "edit-copy";
          command = "${fm} copy-content %F";
          types = [ "text-files" ];
          submenu = "Tools";
        }
        {
          id = "tools-checksum";
          name = "SHA-256 Checksum";
          icon = "dialog-information";
          command = "ghostty -e ${fm} checksum %F";
          types = [ "files" ];
          submenu = "Tools";
        }
        {
          id = "tools-duplicate";
          name = "Duplicate";
          icon = "edit-copy";
          command = "${fm} duplicate %F";
          types = [ "everything" ];
          submenu = "Tools";
        }
        {
          id = "tools-symlink";
          name = "Create Symlink Here";
          icon = "emblem-symbolic-link";
          command = "${fm} symlink %F";
          types = [ "everything" ];
          submenu = "Tools";
        }
        {
          id = "tools-dos2unix";
          name = "Fix Line Endings";
          icon = "text-x-generic";
          command = "dos2unix -- %F";
          types = [ "text-files" ];
          submenu = "Tools";
        }
      ];

      mkServiceMenu =
        {
          id,
          name,
          command,
          icon ? "",
          types ? null,
          mimeTypes ? null,
          submenu ? null,
        }:
        let
          mimes = if mimeTypes != null then mimeTypes else concatMap (t: typeMime.${t}) types;
        in
        concatStringsSep "\n" (
          [
            "[Desktop Entry]"
            "Type=Service"
            "X-KDE-ServiceTypes=KonqPopupMenu/Plugin"
            "MimeType=${concatStringsSep ";" mimes};"
            "Actions=${id};"
          ]
          ++ optional (submenu != null) "X-KDE-Submenu=${submenu}"
          ++ [
            ""
            "[Desktop Action ${id}]"
            "Name=${name}"
            "Icon=${icon}"
            "Exec=${command}"
          ]
        );
    in
    {
      home.packages = [ fmActions ];

      xdg.dataFile = builtins.listToAttrs (
        map (a: {
          name = "kio/servicemenus/${a.id}.desktop";
          value.text = mkServiceMenu a;
        }) actions
      );
    };
}
