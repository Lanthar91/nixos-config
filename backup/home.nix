{ config, pkgs, ... }:

{
  home.username = "el"; # Твой логин
  home.homeDirectory = "/home/el";

  home.packages = with pkgs; [
    fastfetch
    htop
    firefox
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Самое вкусное - Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "robbyrussell"; # Или "agnoster", если любишь powerline
    };
  };
}
