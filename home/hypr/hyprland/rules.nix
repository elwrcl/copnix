{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      { _args = [ "float on" "match:title ^(Open File)(.*)$" ]; }
      { _args = [ "center on" "match:title ^(Open File)(.*)$" ]; }
      { _args = [ "float on" "match:title ^(Save As)(.*)$" ]; }
      { _args = [ "center on" "match:title ^(Save As)(.*)$" ]; }
      { _args = [ "float on" "match:title ^(File Upload)(.*)$" ]; }
      { _args = [ "center on" "match:title ^(File Upload)(.*)$" ]; }
      { _args = [ "float on" "match:class ^(pavucontrol)$" ]; }
      { _args = [ "center on" "match:class ^(pavucontrol)$" ]; }
      { _args = [ "size 45% 45%" "match:class ^(pavucontrol)$" ]; }
      { _args = [ "float on" "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" ]; }
      { _args = [ "pin on" "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" ]; }
      { _args = [ "keep_aspect_ratio on" "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" ]; }
      { _args = [ "immediate on" "match:class ^(steam_app).*" ]; }
      { _args = [ "float on" "match:class ^(steam)$" ]; }
      { _args = [ "float off" "match:class ^(steam)$" "match:title ^(Steam)$" ]; }
    ];
  };
}
