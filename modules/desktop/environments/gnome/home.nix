{ pkgs, ... }:

{
  home.packages = with pkgs; [
    blackbox-terminal
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
  ];

  # Firefox: XWayland mode for stability after suspend
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = false;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      transparency-mode = "FIXED";
      background-opacity = 0.2;
    };
  };
}
