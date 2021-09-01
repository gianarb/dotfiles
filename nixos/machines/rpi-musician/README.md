## Build

```
$ nix build
```

## Try

This is how I test the ISO via Qemu

```terminal
$ qemu-system-x86_64 -boot d -cdrom ./result/iso/nixos.iso -nographic -m 2000
```

NOTE: terminate QEMU session with `Cntrl+A x`.
