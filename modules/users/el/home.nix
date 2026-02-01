{ pkgs, inputs, ... }:

{
  imports = [
    ../../desktop/environments/gnome/home.nix
  ];

  home.username = "el";
  home.homeDirectory = "/home/el";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fastfetch
    htop
    inputs.popai.packages.${pkgs.system}.default
  ];

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;
      settings = {
        # Включить поддержку userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };

  # stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.firefox.enable = true;
  stylix.targets.firefox.firefoxGnomeTheme.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
 programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Elkhan Aliyev";
        email = "elkhan.aliyev.91@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "robbyrussell";
    };
  };
}
