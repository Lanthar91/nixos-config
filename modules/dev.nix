{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    vim
    wget
    claude-code
    gemini-cli
    qemu
    quickemu
    #IDE
    vscode
    code-cursor
     #AI
    qwen-code
    sillytavern
    n8n
    aider-chat-full
    newelle
    crewai
  ];

  programs.git.enable = true;
}
