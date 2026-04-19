''
  layer-rule {
    match namespace="^noctalia-overview.*"
    place-within-backdrop true
  }

  window-rule {
    match title=r#"^(Open File)(.*)$"#
    open-floating true
  }

  window-rule {
    match title=r#"^(Save As)(.*)$"#
    open-floating true
  }

  window-rule {
    match title=r#"^(File Upload)(.*)$"#
    open-floating true
  }

  window-rule {
    match app-id=r#"^pavucontrol$"#
    open-floating true
    default-column-width { proportion 0.45; }
  }

  // Picture-in-Picture — pin desteklenmiyor niri'de
  window-rule {
    match title=r#"(?i)^picture.in.picture"#
    open-floating true
  }

  // Steam: ana pencere tiled, diğerleri floating
  window-rule {
    match app-id=r#"^steam$"#
    open-floating true
  }

  window-rule {
    match app-id=r#"^steam$"#
    match title=r#"^Steam$"#
    open-floating false
  }
''
