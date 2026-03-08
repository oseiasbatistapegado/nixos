#! /bin/sh
# Instalação NixOS multi-host.
# Uso: ./run.sh FENRIR   ou   ./run.sh HUGINN
#
# Cada host tem montagem e discos diferentes; ajuste as variáveis de disco abaixo
# conforme o resultado de lsblk / blkid na máquina alvo.

set -e

HOST="${1:?Uso: $0 FENRIR|HUGINN}"

# Ajuste a URL do repositório se necessário
REPO_URL="${REPO_URL:-https://github.com/oseiasbatistapegado/nixos.git}"

mount /dev/disk/by-label/nixos /mnt
mount --mkdir -o umask=077 /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap

case "$HOST" in
  FENRIR)
    mount --mkdir /dev/disk/by-label/home /mnt/home
    mount --mkdir /dev/disk/by-label/games /mnt/media/games
    HOST_DIR="fenrir"
    ;;
  HUGINN)
    HOST_DIR="huginn"
    ;;
  *)
    echo "Host desconhecido: $HOST. Use FENRIR ou HUGINN." >&2
    exit 1
    ;;
esac

mkdir -p /mnt/etc/nixos
cd /mnt/etc/nixos

# Clone do repositório
git clone "$REPO_URL" .nixos-tmp
cp -r .nixos-tmp/* .
cp -r .nixos-tmp/.git . 2>/dev/null || true
rm -rf .nixos-tmp

# Gera hardware-configuration.nix no diretório do host
nixos-generate-config --root /mnt --dir "/mnt/etc/nixos/hosts/$HOST_DIR"

if ! nixos-install --flake "/mnt/etc/nixos#$HOST" --no-root-passwd; then
  echo "Primeira tentativa falhou, tentando novamente..."
  nixos-install --flake "/mnt/etc/nixos#$HOST" --no-root-passwd
fi

nixos-enter --root /mnt -c 'passwd tux'
