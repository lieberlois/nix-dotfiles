# nix-dotfiles

## Installation

1. Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Configure experimental features

```bash
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

3. Rebuild the system and thus install home-manager

```bash
nix run nix-darwin -- switch .  # MacOS
```
