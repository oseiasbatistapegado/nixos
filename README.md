# NixOS multi-host

Configuração NixOS + Home Manager para vários computadores. Cada máquina é um **host** (ex.: FENRIR, HUGINN); você escolhe qual aplicar com o flake.

## Uso no dia a dia

Na máquina já instalada:

```bash
# Aplicar a config deste host (ex.: no FENRIR)
sudo nixos-rebuild switch --flake /etc/nixos#FENRIR

# Ou no HUGINN
sudo nixos-rebuild switch --flake /etc/nixos#HUGINN
```

Testar sem aplicar: use `--dry-run` ou `boot` em vez de `switch`.

## Estrutura do projeto

- **`flake.nix`** — Define os hosts (`nixosConfigurations.FENRIR`, `nixosConfigurations.HUGINN`, etc.). Cada um junta o módulo do host + Home Manager e o `hardware-configuration.nix` do host (se existir).

- **`hosts/<nome>.nix`** — Entrada do host: `hostName` e lista de imports (common + pasta do host).

- **`hosts/<nome>/`** — Config específica da máquina:
  - `boot.nix` — bootloader, kernel, módulos
  - `dm.nix` — display manager e ambiente (Plasma, Hyprland, etc.)
  - `packages.nix` — pacotes do sistema desse host
  - `systemd.nix` — serviços systemd do host
  - `optional.nix` — bluetooth, cups, firewall, etc.
  - `hardware-configuration.nix` — **não versionado**; gerado com `nixos-generate-config` na instalação.

- **`modules/`** — Módulos usados em todos os hosts (audio, teclado, locale, timezone, users, ssh, network, flake, packages base).

- **`hosts/<nome>/home/`** — Perfis Home Manager por host: `fenrir.nix`, `huginn.nix`, etc.

## Hardware

O `hardware-configuration.nix` (discos, filesystems, etc.) é gerado por você em cada máquina e fica em `hosts/<nome>/hardware-configuration.nix`. Está no `.gitignore` porque depende dos identificadores de disco daquele PC.

Gerar na instalação (com as partições já montadas em `/mnt`):

```bash
nixos-generate-config --root /mnt --dir /mnt/etc/nixos/hosts/fenrir
```

O flake só inclui esse arquivo se ele existir; assim você pode clonar o repo em outra máquina e fazer rebuild só do host que tiver o hardware config lá.

## Instalação nova (script)

O `run.sh` automatiza clone do repo, geração de hardware config e `nixos-install` para um host. Cada host tem um bloco com a montagem de discos (labels) adequada àquela máquina.

```bash
./run.sh FENRIR    # ou  ./run.sh HUGINN
```

Antes de rodar, ajuste as montagens no `case` do script (labels/partições) conforme o resultado de `lsblk` / `blkid` na máquina alvo. Ajuste também a URL do repositório no script ou use `REPO_URL=... ./run.sh HUGINN`.

## Adicionar um novo host

1. Criar `hosts/<novo>.nix` com `hostName` e imports (common + `./<novo>/*.nix`).
2. Criar a pasta `hosts/<novo>/` com `boot.nix`, `dm.nix`, `packages.nix`, `systemd.nix`, `optional.nix` (copiar de um host parecido e adaptar).
3. Criar `hosts/<nome>/home/flake.nix` (perfil do usuário nesse host).
4. No `flake.nix`: novo `nixosConfigurations.<NOVO>`, lista de módulos (host + home-manager + hardware condicional) e entrada no bloco home-manager para `flake.nix`.
5. No `run.sh`: novo `case` com a montagem de discos desse host.
6. No `.gitignore`: `hosts/<novo>/hardware-configuration.nix`.

Depois, na máquina nova: gerar o hardware config em `hosts/<novo>/` e usar `nixos-rebuild --flake /etc/nixos#NOVO` (ou rodar `run.sh NOVO` na instalação limpa).
