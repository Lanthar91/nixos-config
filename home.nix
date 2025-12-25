{ config, pkgs, ... }:

{
  home.username = "user"; # Твой логин
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    fastfetch
    htop
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
