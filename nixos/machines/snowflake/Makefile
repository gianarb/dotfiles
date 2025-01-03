build:
	nix build .#blackhole

local/pixiecore:
	pixiecore boot \
		--cmdline "" \
		--debug \
		./result/initrd \
		./result/bzImage

deploy:
	 #NIX_SSHOPTS="-tt" nixos-rebuild --flake .#snowflake --target-host root@192.168.1.5 --use-remote-sudo --impure switch
	 nixos-rebuild --flake .#snowflake --target-host root@192.168.1.5 --impure switch
