{ pkgs, ... }:

{
  imports = [
    ./labwc.nix
    ./sfwbar.nix
  ];

  home.packages = with pkgs; [
    labwc              # Wayland compositor
    swaybg             # Wallpaper
    grim               # Screenshot
    slurp              # Region selection
    swappy             # Screenshot annotation
    wlsunset           # Night light (optional)
    polkit_gnome       # Polkit agent
    xfce.thunar        # File Manager
    xed-editor         # Text editor
    crystal-dock       # Dock
    pavucontrol        # Audio GUI
    playerctl          # Media player control
  ];

  # Environment variables
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Auto-start labwc from TTY1
  programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      exec labwc
    fi
  '';

  # Foot terminal
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  # Fuzzel launcher
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "foot";
        layer = "overlay";
        width = 40;
        lines = 10;
      };
      border = {
        radius = 8;
        width = 2;
      };
    };
  };

  # Mako notifications
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      layer = "overlay";
      border-radius = 8;
      border-size = 2;
      padding = "10";
      margin = "10";
    };
  };

  # Idle management - suspend after 10 min
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "playerctl pause";
    };
    timeouts = [
      { timeout = 600; command = "systemctl suspend"; }  # 10 min
    ];
  };
}
