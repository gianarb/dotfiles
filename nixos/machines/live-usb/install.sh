DEVICE="/dev/sda"
parted  $DEVICE -- mklabel gpt
parted $DEVICE -- mkpart primary 512MiB 100%
parted $DEVICE -- mkpart ESP fat32 1MiB 512MiB
parted $DEVICE -- set 2 esp on

mkfs.ext4 -L ROOT "${DEVICE}1"
mkfs.fat -F32 -n BOOT "${DEVICE}2"
mkswap -L SWAP "${DEVICE}3"

mount /dev/disk/by-label/ROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/BOOT /mnt/boot
swapon /dev/disk/by-label/SWAP

# copy configuration and hardware
#
#

## run nixos install
nixos-install --root /mnt
