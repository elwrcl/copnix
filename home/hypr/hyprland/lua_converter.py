#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3

import sys
import re
import os

def convert_file(filepath):
    if not os.path.isfile(filepath):
        return

    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    new_lines = []
    changed = False

    # "CTRL $mainMod, right, layoutmsg, focus r"
    pattern = re.compile(r'^(\s*)"([^"]*,[^"]*)"\s*$')

    for line in lines:
        match = pattern.match(line)
        if match:
            indent = match.group(1)
            content = match.group(2)
            parts = [f'"{p.strip()}"' for p in content.split(',')]
            args_str = " ".join(parts)
            new_line = f'{indent}{{ _args = [ {args_str} ]; }}\n'
            new_lines.append(new_line)
            changed = True
        else:
            new_lines.append(line)
    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f"Converted: {filepath}")
    else:
        print(f"Skipped (no changes): {filepath}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 lua_converter.py <file1.nix> <file2.nix> ...")
        sys.exit(1)

    for file in sys.argv[1:]:
        convert_file(file)
