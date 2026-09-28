{ ... }:
{
  flake.homeModules.home-agents-claude =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.lists) concatMap singleton;
      inherit (lib.strings) concatLines;
      inherit (lib.generators) toJSON;
      inherit (lib.meta) getExe;
      allowed.commands = [
        "rg*"
        "ls*"

        "jj bookmark list*"
        "jj config get*"
        "jj config list*"
        "jj config path*"
        "jj diff*"
        "jj evolog*"
        "jj file annotate*"
        "jj file list*"
        "jj file search*"
        "jj file show*"
        "jj file track*"
        "jj git colocation status*"
        "jj git remote list*"
        "jj git root*"
        "jj help*"
        "jj interdiff*"
        "jj log*"
        "jj op diff*"
        "jj op log*"
        "jj op show*"
        "jj operation diff*"
        "jj operation log*"
        "jj operation show*"
        "jj resolve --list"
        "jj root*"
        "jj show*"
        "jj sparse list*"
        "jj st*"
        "jj status*"
        "jj tag list*"
        "jj util completion*"
        "jj util config-schema*"
        "jj util markdown-help*"
        "jj version*"
        "jj workspace list*"
        "jj workspace root*"

        "gh auth status*"
        "gh cache list*"
        "gh gist list*"
        "gh gist view*"
        "gh issue list*"
        "gh issue status*"
        "gh issue view*"
        "gh label list*"
        "gh pr checks*"
        "gh pr diff*"
        "gh pr list*"
        "gh pr status*"
        "gh pr view*"
        "gh release list*"
        "gh release view*"
        "gh repo list*"
        "gh repo view*"
        "gh run list*"
        "gh run view*"
        "gh status*"
        "gh workflow list*"
        "gh workflow view*"

        "nix build*"
        "nix develop*"
        "nix eval*"
        "nix flake archive*"
        "nix flake check*"
        "nix flake metadata*"
        "nix flake show*"
        "nix path-info*"
        "nixfmt*"

        "cargo clippy*"
        "cargo nextest*"
      ];

      forbidden.rules = [
        {
          commands = singleton "git*";
          justification = "Use `jj` for version control.";
        }
        {
          commands = [
            "nix-build*"
            "nix-shell*"
            "nix-instantiate*"
            "nix-env*"
            "nix-channel*"
          ];
          justification = "Use nix3 commands (`nix build`, `nix develop`, `nix flake check`, ...) instead of legacy nix-* commands.";
        }
        {
          commands = singleton "cargo check*";
          justification = "Use `cargo clippy` instead of `cargo check`.";
        }
        {
          commands = singleton "cargo test*";
          justification = "Use `cargo nextest` instead of `cargo test`.";
        }
        {
          commands = [
            "find /nix/store"
            "find /nix/store *"
            "find /nix/store/"
            "find /nix/store/ *"
          ];
          justification = "Don't `find` over the entire `/nix/store`. Search specific store paths obtained from the flake instead.";
        }
      ];

      instructions =
        [
          "Never write a manual `imports = [ ... ]` list in a dendritic (*.ulu.nix) flake; discovery is automatic."
          "Prefer nix3 commands (`nix build`, `nix flake check`, ...) over nix2/nix1 commands."
        ]
        ++ (forbidden.rules |> map ({ justification, ... }: justification))
        |> map (instruction: ''
          - ${instruction}
        '')
        |> concatLines;

      allowed.paths = [
        "/etc/profiles"
        "/nix/store"
      ];

      # more bittersweet
      statusLine = pkgs.writers.writeNuBin "claude-code-statusline" /* nu */ ''
        def format-duration [ms: int] {
          let total_s = $ms // 1000
          let h = $total_s // 3600
          let m = ($total_s mod 3600) // 60
          let s = $total_s mod 60
          if $h > 0 {
            $"($h)h($m | fill -a r -w 2 -c '0')m($s | fill -a r -w 2 -c '0')s"
          } else if $m > 0 {
            $"($m)m($s | fill -a r -w 2 -c '0')s"
          } else {
            $"($s)s"
          }
        }

        def color-for-pct [pct: number] {
          let pct_int = $pct | math floor | into int
          if $pct_int >= 80 {
            "\e[31m"
          } else if $pct_int >= 50 {
            "\e[33m"
          } else {
            "\e[32m"
          }
        }

        def format-rate-limits [input: record] {
          let session_pct = try { $input | get rate_limits.five_hour.used_percentage } catch { null }
          let week_pct = try { $input | get rate_limits.seven_day.used_percentage } catch { null }

          let session_part = if $session_pct != null {
            let c = color-for-pct $session_pct
            let v = $session_pct | math round --precision 0 | into int
            $"session: ($c)($v)%\e[0m"
          } else { "" }
          let week_part = if $week_pct != null {
            let c = color-for-pct $week_pct
            let v = $week_pct | math round --precision 0 | into int
            $"week: ($c)($v)%\e[0m"
          } else { "" }

          [$session_part $week_part] | where {|x| $x | is-not-empty} | str join " "
        }

        def get-jj-info [] {
          let root_result = do { jj --ignore-working-copy root } | complete
          if $root_result.exit_code != 0 { return "" }

          # --ignore-working-copy so a killed render can't leave the working
          # copy stale; the watchman snapshot trigger keeps the data fresh.
          let bookmark = (do { jj --ignore-working-copy log -r @ --no-graph -T 'bookmarks.map(|b| b.name()).join(", ")' } | complete | get stdout | str trim)
          let change = (do { jj --ignore-working-copy log -r @ --no-graph -T 'change_id.shortest(8)' } | complete | get stdout | str trim)
          let is_empty_str = (do { jj --ignore-working-copy log -r @ --no-graph -T 'empty' } | complete | get stdout | str trim)
          let dirty = if $is_empty_str == "false" { "*" } else { "" }
          let has_conflict = (do { jj --ignore-working-copy log -r @ --no-graph -T 'conflict' } | complete | get stdout | str trim)
          let conflict_marker = if $has_conflict == "true" { " \e[31m!conflict\e[0m" } else { "" }

          let ref_part = if ($bookmark | is-not-empty) {
            $" | \e[36m($bookmark)($dirty)\e[0m"
          } else if ($change | is-not-empty) {
            $" | \e[35m($change)($dirty)\e[0m"
          } else { "" }

          $"($ref_part)($conflict_marker)"
        }

        # --- Main ---
        let input = (^cat | from json)

        let usage_info = format-rate-limits $input

        let model_name = ($input | get model?.display_name? | default ($input | get model?.id? | default "unknown"))
        let used_pct = ($input | get context_window?.used_percentage? | default null)
        let total_cost = ($input | get cost?.total_cost_usd? | default 0)
        let total_input = ($input | get context_window?.s_in? | default ($input | get context_window?.total_input_tokens? | default 0))
        let total_output = ($input | get context_window?.s_out? | default ($input | get context_window?.total_output_tokens? | default 0))
        let duration_ms = ($input | get cost?.total_duration_ms? | default 0)
        let api_duration_ms = ($input | get cost?.total_api_duration_ms? | default 0)
        let lines_added = ($input | get cost?.total_lines_added? | default 0)
        let lines_removed = ($input | get cost?.total_lines_removed? | default 0)
        let exceeds_200k = ($input | get exceeds_200k_tokens? | default false)

        let cache_read = ($input | get context_window?.cache_read_tokens? | default 0)
        let cache_create = ($input | get context_window?.cache_creation_tokens? | default 0)

        let total_tokens = $total_input + $total_output

        def format-tokens [n: int] {
          if $n >= 1_000_000 {
            $"($n / 1_000_000.0 | math round --precision 1)M"
          } else if $n >= 1_000 {
            $"($n / 1_000.0 | math round --precision 1)k"
          } else {
            $"($n)"
          }
        }

        let in_display = (format-tokens ($total_input | into int))
        let out_display = (format-tokens ($total_output | into int))
        let tok_display = $"($in_display)/($out_display)"

        let cache_total = $cache_read + $cache_create
        let cache_display = if $cache_total > 0 {
          let cache_pct = ($cache_read * 100 / $cache_total | math round --precision 0 | into int)
          let cache_color = if $cache_pct >= 70 {
            "\e[32m"
          } else if $cache_pct >= 40 {
            "\e[33m"
          } else {
            "\e[31m"
          }
          $" cache:($cache_color)($cache_pct)%\e[0m"
        } else { "" }

        let context_display = if $used_pct != null {
          let color = color-for-pct $used_pct
          let pct_str = $used_pct | math round --precision 1
          $"($color)($pct_str)%\e[0m"
        } else { "--" }

        let cost_cents = ($total_cost * 100 | math round | into int)
        let cost_dollars = $cost_cents // 100
        let cost_frac = ($cost_cents mod 100 | math abs | into string | fill -a r -w 2 -c '0')
        let cost_display = $"$($cost_dollars).($cost_frac)"
        let elapsed_display = (format-duration ($duration_ms | into int))
        let wait_display = (format-duration ($api_duration_ms | into int))
        let churn_display = $"\e[32m+($lines_added)\e[0m/\e[31m-($lines_removed)\e[0m"
        let marker_200k = if $exceeds_200k { " | \e[31m!200k\e[0m" } else { "" }
        def format-cwd [dir: string] {
          if ($dir | is-empty) { return "" }
          let jj_root = try { do { cd $dir; jj workspace root } | complete } catch { {exit_code: 1, stdout: ""} }
          if $jj_root.exit_code == 0 {
            let root = ($jj_root.stdout | str trim)
            let home = ($env.HOME? | default "")
            let root_display = if ($home | is-not-empty) and ($root | str starts-with $home) {
              let rel = ($root | str replace $home "" | str trim -l -c '/')
              $"~/($rel)"
            } else {
              $root
            }
            let root_parts = ($root_display | split row "/")
            let base = if ($root_parts | length) <= 5 {
              $root_display
            } else {
              let tail = ($root_parts | last 5 | str join "/")
              $"…/($tail)"
            }
            let subpath = if ($dir | str starts-with $root) {
              $dir | str replace $root "" | str trim -l -c '/'
            } else { "" }
            if ($subpath | is-not-empty) {
              $"\e[36m($base)\e[0m → \e[34m($subpath)\e[0m"
            } else {
              $"\e[36m($base)\e[0m"
            }
          } else {
            let home = ($env.HOME? | default "")
            let display = if ($home | is-not-empty) and ($dir | str starts-with $home) {
              let rel = ($dir | str replace $home "" | str trim -l -c '/')
              $"~/($rel)"
            } else {
              $dir
            }
            let parts = ($display | split row "/")
            let shortened = if ($parts | length) <= 5 {
              $display
            } else {
              let tail = ($parts | last 5 | str join "/")
              $"…/($tail)"
            }
            $shortened
          }
        }

        let cwd_raw = ($input | get workspace?.current_dir? | default "")
        let cwd_display = if ($cwd_raw | is-not-empty) {
          let formatted = (format-cwd $cwd_raw)
          $" | ($formatted)"
        } else { "" }
        let jj_info = get-jj-info
        let quota_section = if ($usage_info | is-not-empty) {
          " | (usage) " + $usage_info
        } else { "" }

        print -n $"($model_name) | Ctx: ($context_display) | ($tok_display)($cache_display) | ($cost_display) | t:($elapsed_display) w:($wait_display) | ($churn_display)($marker_200k)($jj_info)($quota_section)($cwd_display)"
      '';

      settingsPath = "${config.home.homeDirectory}/.claude/settings.json";
      managedSettings =
        pkgs.writeText "claude-code-settings.json"
        <| toJSON { } {
          "$schema" = "https://json.schemastore.org/claude-code-settings.json";

          cleanupPeriodDays = 365 * 1000;
          permissions.allow =
            [ ]
            ++ map (cmd: "Bash(${cmd})") allowed.commands
            ++ map (path: "Read(${path}/**)") allowed.paths
            ++ [
              "Glob"
              "Grep"
              "LSP"
              "WebFetch"
              "WebSearch"
              "TaskCreate"
              "TaskUpdate"
              "TaskGet"
              "TaskList"
              "TaskOutput"
              "TaskStop"
            ];
          permissions.deny =
            forbidden.rules |> concatMap (rule: rule.commands |> map (command: "Bash(${command})"));

          env.CLAUDE_BASH_NO_LOGIN = "1";
          env.CLAUDE_CODE_EAGER_FLUSH = "1";
          env.CLAUDE_CODE_FORCE_GLOBAL_CACHE = "1";
          env.MCP_CONNECTION_NONBLOCKING = "1";
          env.USE_BUILTIN_RIPGREP = "0";

          # bittersweet
          alwaysThinkingEnabled = true;
          env.CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING = "1";
          env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
          env.CLAUDE_CODE_MAX_TOOL_USE_CONCURRENCY = "20";
          env.CLAUDE_CODE_PLAN_V2_AGENT_COUNT = "5";
          env.CLAUDE_CODE_PLAN_V2_EXPLORE_AGENT_COUNT = "5";
          env.DISABLE_AUTO_COMPACT = "1";
          env.ENABLE_MCP_LARGE_OUTPUT_FILES = "1";
          env.ENABLE_TOOL_SEARCH = "auto:5";
          env.MAX_THINKING_TOKENS = "31999";

          # less slops unfortunately
          skipWebFetchPreflight = true;
          env.CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY = "1";
          env.DISABLE_AUTOUPDATER = "1";
          env.DISABLE_ERROR_REPORTING = "1";
          env.DISABLE_INSTALLATION_CHECKS = "1";
          # env.DISABLE_TELEMETRY = "1";

          # tools: jj workspaces track claude-code's own git-style worktrees.
          hooks.WorktreeCreate = singleton {
            hooks = singleton {
              type = "command";
              command = /* bash */ ''jj workspace add "$(cat /dev/stdin | jq '.name' --raw-output)"'';
            };
          };
          hooks.WorktreeRemove = singleton {
            hooks = singleton {
              type = "command";
              command = /* bash */ ''jj workspace forget "$(cat /dev/stdin | jq '.worktree_path' --raw-output)"'';
            };
          };

          enabledPlugins."code-review@claude-plugins-official" = true;
          enabledPlugins."code-simplifier@claude-plugins-official" = true;
          enabledPlugins."ralph-loop@claude-plugins-official" = true;

          # visuals
          attribution.commit = "";
          attribution.pr = "";

          env.CLAUDE_CODE_DISABLE_TERMINAL_TITLE = "1";
          env.CLAUDE_CODE_HIDE_ACCOUNT_INFO = "1";
          env.DISABLE_COST_WARNINGS = "1";

          statusLine.type = "command";
          statusLine.command = getExe statusLine;

          spinnerVerbs.mode = "replace";
          spinnerVerbs.verbs = [
            "Redeeming"
            "Clodding"
            "Burningtokens"
            "Slopping"
            "Clanking"
            "Flushing"
            "4get'ing"
            "Plundering"
            "Ignoring"
            "Increasing ram prices"
            "Making shit up"
            "Hallucinating"
            "Esef thinking"
            "Doing something"
            "Bain mode"
            "Hyprland sucks"
            "Stealing big one"
            "Selling your data"
            "Outsourcing to Nürburgring Betriebsgesellschaft mbH Otto-Flimm-Straße 53520 Nürburg"
            "Compiling Earth"
            "Absolute Cinema"
            "Trvth Nvke"
            "Glory to Caledonia"
            "Mohamed Salah hat-trick"
            "Sebasitan Vettel ring ding ding ding"
          ];
        };
    in
    {
      home.file.".claude/CLAUDE.md".text = instructions;
      home.activation.claudeCodeWritableSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        _target="${settingsPath}"
        _jq="${getExe pkgs.jq}"
        run mkdir -p "$(dirname "$_target")"
        if [ -s "$_target" ] && "$_jq" empty "$_target" 2>/dev/null; then
          _merged="$(mktemp)"
          "$_jq" --slurp '.[0] * .[1]' "$_target" ${managedSettings} > "$_merged"
          run install -m 0644 "$_merged" "$_target"
          rm -f "$_merged"
        else
          run install -m 0644 ${managedSettings} "$_target"
        fi
      '';
    };
}
