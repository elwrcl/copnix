#!/usr/bin/env bash
# Copy the release build of the intel-hard-graphics mesa fork into this
# directory; hw-ivb-drivers turns the files into the system's Vulkan (hasvk),
# Direct3D 9 (gallium nine) and OpenCL (rusticl) drivers.
#
#   drivers/ivb/update.sh            ninja + install both release builds, copy
#   nixos-rebuild switch             then
#
# The release builds are configured in the fork (meson setup release /
# release32, see its flake's release shells, pinned to this system's nixpkgs).
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
fork=${IVB_FORK:-/mnt/HDD/linuxdata/Projects_XFS/Drivers/intel-hard-graphics}

stage() { # build dir, profile, arch dir, files...
  local build=$1 profile=$2 arch=$3
  shift 3
  local tmp
  tmp=$(mktemp -d)
  (cd "$fork" && nix develop ".profiles/$profile" -c ninja -C "$build" &&
    nix develop ".profiles/$profile" -c meson install -C "$build" --no-rebuild \
      --destdir "$tmp" --quiet)
  mkdir -p "$here/$arch"
  for f in "$@"; do
    install -m 0755 "$tmp/usr/local/lib/$f" "$here/$arch/$(basename "$f")"
  done
  rm -rf "$tmp"
}

stage release release x86_64 \
  libvulkan_intel_hasvk13.so d3d/d3dadapter9.so.1 libRusticlOpenCL.so.1
stage release32 release-i686 i686 \
  libvulkan_intel_hasvk13.so d3d/d3dadapter9.so.1

(cd "$fork" && printf '%s\n' "$(jj log -r @- --no-graph -T 'commit_id.short() ++ " " ++ description.first_line()' 2>/dev/null ||
  git rev-parse --short HEAD 2>/dev/null)") > "$here/SOURCE"
ls -la "$here"/x86_64 "$here"/i686
echo "source: $(cat "$here/SOURCE")"
