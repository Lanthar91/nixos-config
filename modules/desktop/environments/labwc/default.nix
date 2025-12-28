{ pkgs, ... }:

{
  # TTY autologin
  services.getty.autologinUser = "el";

  # XWayland for X11 app compatibility
  programs.xwayland.enable = true;

  # Wayland utilities
  environment.systemPackages = with pkgs; [
    wl-clipboard       # Clipboard
    xdg-utils          # xdg-open, etc.
    wlr-randr          # Display configuration
  ];

  # XDG portal for wlroots compositors
  xdg.portal.wlr.enable = true;

  # Environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Electron apps native Wayland
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "wlroots";
    # Keyboard layout: US/RU, Alt+Shift to toggle
    XKB_DEFAULT_LAYOUT = "us,ru";
    XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle";
  };
}
