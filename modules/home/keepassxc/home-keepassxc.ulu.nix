{ ... }:
{
  flake.homeModules.home-keepassxc =
    { ... }:
    {
      programs.keepassxc = {
        enable = true;
        settings = {
          Browser = {
            Enabled = true;
            UpdateBinaryPath = false;
          };
          Security = {
            LockDatabaseIdle = true;
            LockDatabaseIdleSeconds = 900;
            ClearClipboardTimeout = 20;
          };
        };
      };
    };
}
