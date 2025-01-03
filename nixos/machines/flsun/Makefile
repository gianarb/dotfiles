flake:
	nix build .#nixosConfigurations.rpi.config.system.build.sdImage
deploy:
	nixos-rebuild --flake .#nuc --target-host root@192.168.1.14 switch

