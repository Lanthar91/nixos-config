{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  # =================================================
  # ГРАФИКА И ОКРУЖЕНИЕ (PLASMA 6 + WAYLAND)
  # =================================================
  services.xserver = {
  xkb.layout = "us,ru";
  xkbOptions = "grp:alt_shift_toggle";
};

  # Включаем X11 (нужен для SDDM и совместимости)
  services.xserver.enable = true;

  # Дисплейный менеджер SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Окружение Plasma 6
  services.desktopManager.plasma6.enable = true;

  # =================================================
  # НАСТРОЙКИ NVIDIA
  # =================================================

  # 1. Загружаем драйвер
  services.xserver.videoDrivers = [ "nvidia" ];

  # 2. Включаем аппаратное ускорение (OpenGL/Vulkan)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Важно для Steam и 32-битных игр
  };

  # 3. Тонкая настройка драйвера
  hardware.nvidia = {
    # Самое важное для Wayland. Включает DRM Kernel Mode Setting.
    # Без этого будет черный экран или курсор на черном фоне.
    modesetting.enable = true;

    # Управление питанием (экспериментально, часто лучше выключить на десктопе)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Использовать открытые модули ядра (open kernel modules)?
    # Для новых карт (Turing/Ampere+) можно true, но проприетарные (false) пока стабильнее.
    open = false;

    # Включает утилиту настройки nvidia-settings
    nvidiaSettings = true;

    # Выбор версии драйвера.
    # stable - стабильный
    # beta - бета (свежие фичи для Wayland)
    # production - проверенный временем
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # =================================================
  # ЗВУК (PIPEWIRE)
  # =================================================
  services.pulseaudio.enable = false; # Вырубаем старье
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Шрифты (чтобы глаза не вытекли в консоли и браузере)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
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

nixpkgs.config.allowUnfree = true;

  # СИСТЕМНЫЕ ПАКЕТЫ
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    home-manager
  ];

  system.stateVersion = "26.05"; 
}
