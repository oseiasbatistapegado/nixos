#! /bin/sh

mount /dev/disk/by-label/nixos /mnt
mount --mkdir -o umask=077 /dev/disk/by-label/boot /mnt/boot
mount --mkdir /dev/disk/by-label/home /mnt/home
mount --mkdir /dev/disk/by-label/games /mnt/media/games

swapon /dev/disk/by-label/swap

nixos-generate-config --root /mnt

cd /mnt/etc/nixos

git clone https://github.com/oseiasbatistapegado/nixos.git

mv -i nixos .nixos

cp -r .nixos/modules .
cp .nixos/configuration.nix .
cp .nixos/flake.nix .

if ! nixos-install --flake '/mnt/etc/nixos#tux' --no-root-passwd; then
    echo "Primeira tentativa falhou, tentando novamente..."
    nixos-install --flake '/mnt/etc/nixos#tux' --no-root-passwd
fi

nixos-enter --root /mnt -c 'passwd tux'
