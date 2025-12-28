{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    vim
    wget
    claude-code
    gemini-cli
  ];

  programs.git.enable = true;
}
