{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.el = {
    isNormalUser = true;
    description = "el";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh;
  };
}
