{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # ЗАГРУЗЧИК (Оставь как сгенерировалось или пропиши явно)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # СЕТЬ
  networking.hostName = "nixos"; # Должно совпадать с именем во flake.nix!
  networking.networkmanager.enable = true;

  # ВРЕМЕННАЯ ЗОНА
  time.timeZone = "Europe/Moscow"; # Поставь свой пояс

  # ВАЖНО: Включаем Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ПОЛЬЗОВАТЕЛИ
  users.users.user = { # Замени на свой логин
    isNormalUser = true;
    description = "My User";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # СИСТЕМНЫЕ ПАКЕТЫ
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    home-manager
  ];

  system.stateVersion = "24.11"; 
}
