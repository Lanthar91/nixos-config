# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

NixOS flake-based configuration for a desktop system running GNOME on Wayland with NVIDIA graphics.

## Build Commands

```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#nixos

# Test build without switching
sudo nixos-rebuild build --flake .#nixos

# Check flake for errors (requires: git add -A)
nix flake check

# Update all flake inputs
nix flake update
```

## Structure

```
flake.nix                    # Entry point, inputs (nixpkgs-unstable, home-manager)
hosts/nixos/
  default.nix                # Host config, imports all modules
  hardware-configuration.nix # Auto-generated hardware config (btrfs subvolumes)
modules/
  desktop/gnome.nix          # GNOME, GDM, PipeWire, fonts
  hardware/nvidia.nix        # NVIDIA drivers with modesetting
  system/
    boot.nix                 # systemd-boot
    locale.nix               # Timezone, keyboard layouts
    networking.nix           # Hostname, NetworkManager
  users/el/
    default.nix              # User account, shell
    home.nix                 # Home Manager: zsh, oh-my-zsh, user packages
  dev.nix                    # Dev tools (git, vim, claude-code)
backup/                      # Backup of original flat configs
```

## Key Details

- **Host**: `nixos` (must match `networking.hostName`)
- **User**: `el` with auto-login
- **Desktop**: GNOME + GDM on Wayland
- **Graphics**: NVIDIA proprietary (modesetting enabled)
- **Keyboard**: US/RU, Alt+Shift toggle
