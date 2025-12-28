# Labwc NixOS Module

This directory contains a modular NixOS and Home Manager configuration for **Labwc**, a stacking Wayland compositor inspired by Openbox. It provides a complete, lightweight, and customizable desktop environment.

## Directory Structure

*   **`default.nix`**: System-level configuration.
*   **`home.nix`**: Home Manager configuration entry point.
*   **`labwc.nix`**: Detailed Labwc configuration (XML config files and autostart).
*   **`waybar.nix`**: Configuration for the Waybar status bar.

## Components & Configuration

### 1. System Configuration (`default.nix`)
*   **Wayland Support**: Enables `xdg-desktop-portal-wlr` for screen sharing and other portal features.
*   **XWayland**: Enabled for X11 application compatibility.
*   **Environment Variables**: Sets `NIXOS_OZONE_WL=1` (for Electron apps), `XDG_SESSION_TYPE=wayland`, and keyboard layouts (US/RU).
*   **System Packages**: Installs essential Wayland tools like `wl-clipboard`, `wlr-randr`, and `xdg-utils`.

### 2. Home Manager Configuration (`home.nix`)
*   **Packages**: Installs the desktop environment suite:
    *   **Core**: `labwc`, `swaybg` (wallpaper), `polkit_gnome`.
    *   **Tools**: `grim`/`slurp`/`swappy` (screenshots), `xfce.thunar` (file manager), `pavucontrol` (audio control).
    *   **UI**: `crystal-dock`, `mako` (notifications), `fuzzel` (app launcher), `foot` (terminal).
*   **Autostart**: Configures `zsh` to automatically launch `labwc` on TTY1 login.
*   **Program Configs**: detailed settings for `foot`, `fuzzel`, and `mako`.

### 3. Labwc Specifics (`labwc.nix`)
Directly generates configuration files in `~/.config/labwc/`:
*   **`rc.xml`**: Defines window management behavior and keybindings.
    *   **Keybindings**:
        *   `Super+Return`: Terminal (Foot)
        *   `Super+D`: Launcher (Fuzzel)
        *   `Super+Q`: Close Window
        *   `Super+F`: Toggle Fullscreen
        *   `Super+M`: Toggle Maximize
        *   `Print` / `Super+Print`: Screenshots (Region / Full)
        *   `Super+Arrows`: Window snapping
        *   `Super+1-4`: Workspace switching
    *   **Mouse**: Double-click title bar to maximize, Right-click root for menu.
*   **`menu.xml`**: Right-click context menu structure.
*   **`autostart`**: Shell script executed on login.
    *   Sets refresh rate (via `wlr-randr`).
    *   Starts `swaybg`, `mako`, `waybar`, `crystal-dock`, and the polkit agent.

### 4. Status Bar (`waybar.nix`)
*   Configures a top-aligned status bar.
*   **Modules**: Workspaces, Clock, PulseAudio, Network, Battery, Tray.
*   **Style**: Custom CSS for a rounded, "floating" look.

## Usage

To use this module in your NixOS setup:

1.  **System-wide**: Import `default.nix` in your machine's `configuration.nix`.
2.  **User-level**: Import `home.nix` in your Home Manager configuration (usually `home.nix` or a user module).

## Customization

*   **Wallpaper**: Update the path in `labwc.nix` (currently `~/nixos-config/wallpapers/wallpaper.png`).
*   **Monitor**: The `autostart` script sets a specific mode for `DP-3`. Update this for your specific display hardware using `wlr-randr`.
