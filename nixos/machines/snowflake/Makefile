build:
	nix build .#blackhole

local/pixiecore:
	pixiecore boot \
		--cmdline "" \
		--debug \
		./result/initrd \
		./result/bzImage
