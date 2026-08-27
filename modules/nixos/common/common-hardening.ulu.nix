{ ... }:
{
  flake.nixosModules.common-hardening =
    { ... }:
    {
      boot.kernel.sysctl = {
        "kernel.dmesg_restrict" = 1; # Restrict dmesg access to privileged users.
        "kernel.unprivileged_bpf_disabled" = 1; # Disable unprivileged BPF to reduce attack surface.
        "fs.protected_fifos" = 2; # Prevent unsafe FIFO use in sticky world-writable dirs.
        "fs.protected_regular" = 2; # Prevent unsafe regular file access in sticky world-writable dirs.
      };

      boot.kernelParams = [
        "randomize_kstack_offset=on" # Randomize kernel stack offset for harder exploitation.
        "page_alloc.shuffle=1" # Randomize page allocator free lists.
        "slab_nomerge" # Disable slab merging to reduce cross-cache attacks.
        "vsyscall=xonly" # Keep legacy vsyscall execute-only for compatibility with less exposure.
      ];

      boot.blacklistedKernelModules = [
        "af_802154" # IEEE 802.15.4 wireless networking stack.
        "appletalk" # AppleTalk networking stack.
        "atm" # Asynchronous Transfer Mode networking.
        "ax25" # Amateur X.25 networking.
        "can" # Controller Area Network; used for vehicle and industrial buses.
        "dccp" # Datagram Congestion Control Protocol.
        "decnet" # DECnet networking stack.
        "econet" # Acorn Econet networking.
        "ipx" # Novell IPX protocol stack.
        "n-hdlc" # HDLC framing support.
        "netrom" # NetRom amateur packet networking.
        "p8022" # IEEE 802.2 LLC networking.
        "p8023" # Novell raw IEEE 802.3 Ethernet.
        "psnap" # IEEE 802.2 SNAP protocol.
        "rds" # Reliable Datagram Sockets.
        "rose" # ROSE networking stack.
        "sctp" # Stream Control Transmission Protocol.
        "tipc" # Transparent Inter-Process Communication.
        "x25" # CCITT X.25 networking.

        "adfs" # Adaptec ADFS filesystem.
        "affs" # Amiga Fast File System.
        "befs" # BeOS File System.
        "bfs" # BFS filesystem.
        "cramfs" # Compressed ROM filesystem.
        "efs" # EFS filesystem.
        "erofs" # Enhanced Read-Only File System.
        "exofs" # EXOFS filesystem.
        "f2fs" # Flash-Friendly File System.
        "freevxfs" # Veritas VxFS filesystem.
        "gfs2" # Global Filesystem 2.
        "hfs" # Classic Mac HFS; hfsplus is a separate module and is not blacklisted.
        "hpfs" # OS/2 High Performance File System.
        "jffs2" # Journaling Flash File System v2.
        "jfs" # IBM JFS filesystem.
        "ksmbd" # SMB3 server module; the CIFS client is not blacklisted.
        "minix" # Minix filesystem.
        "nilfs2" # New Implementation of Log-structured File System v2.
        "omfs" # Open Micro File System.
        "qnx4" # QNX 4 filesystem.
        "qnx6" # QNX 6 filesystem.
        "sysv" # System V filesystem.
        "udf" # DVD/ISO filesystem; load manually if mounting is needed on the host.
        "vivid" # Virtual video test driver.
        "firewire-core" # FireWire core stack.
        "thunderbolt" # Thunderbolt networking/storage driver stack.
      ];
    };
}
