{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.el = {
    isNormalUser = true;
    description = "el";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    shell = pkgs.zsh;
  };
}
