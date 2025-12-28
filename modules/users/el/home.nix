{ pkgs, ... }:

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
    firefox
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.reversal-icon-theme;
      name = "Reversal";
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
