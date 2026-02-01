# NixOS Configuration

Flake-based конфигурация NixOS для десктопной системы с GNOME на Wayland и видеокартой NVIDIA.

## Быстрый старт

```bash
# Пересборка и переключение на новую конфигурацию
sudo nixos-rebuild switch --flake .#nixos

# Тестовая сборка без переключения
sudo nixos-rebuild build --flake .#nixos

# Проверка flake на ошибки (требуется: git add -A)
nix flake check

# Обновление всех inputs
nix flake update
```

## Структура проекта

```
flake.nix                                    # Точка входа, inputs и outputs
flake.lock                                   # Зафиксированные версии inputs
hosts/nixos/
  default.nix                                # Конфигурация хоста, импорт всех модулей
  hardware-configuration.nix                 # Автоматически сгенерированная конфигурация железа
modules/
  system/
    boot.nix                                 # Загрузчик (systemd-boot)
    locale.nix                               # Часовой пояс и раскладка клавиатуры
    networking.nix                           # Имя хоста и сеть
  hardware/
    nvidia.nix                               # Драйверы NVIDIA
  desktop/
    common.nix                               # Общие настройки рабочего стола (PipeWire, шрифты, XDG)
    stylix.nix                               # Тема и стилизация (Catppuccin Latte)
    environments/
      gnome/
        default.nix                          # GNOME + GDM
        home.nix                             # Пакеты и расширения GNOME для пользователя
      labwc/
        default.nix                          # Labwc (альтернативный Wayland-композитор)
        home.nix                             # Home Manager для Labwc
        labwc.nix                            # Конфигурация Labwc (горячие клавиши, воркспейсы)
        sfwbar.nix                           # Панель задач для Labwc
  users/el/
    default.nix                              # Учётная запись пользователя
    home.nix                                 # Home Manager (zsh, git, пакеты)
  dev.nix                                    # Инструменты разработки
  services/
    mariadb.nix                              # Сервер MariaDB
  virtualisation/
    docker.nix                               # Docker с btrfs
    waydroid.nix                             # Эмуляция Android
backup/                                      # Бэкап оригинальных монолитных конфигов
wallpapers/                                  # Обои рабочего стола
```

## Описание модулей

### flake.nix

Точка входа. Определяет inputs:
- **nixpkgs** — nixpkgs-unstable
- **home-manager** — управление пользовательской конфигурацией
- **stylix** — единая система тем
- **PopAI** — кастомный пакет

Создаёт конфигурацию `nixosConfigurations.nixos` для архитектуры x86_64-linux.

### hosts/nixos/default.nix

Центральный хаб импорта. Подключает все модули, включает экспериментальные фичи Nix (`nix-command`, `flakes`), разрешает unfree-пакеты, настраивает zramSwap (50% памяти).

### hosts/nixos/hardware-configuration.nix

Автоматически сгенерированная конфигурация:
- **Файловая система**: Btrfs с subvolumes (`@`, `@home`, `@nix`), сжатие zstd
- **CPU**: Intel (модуль kvm-intel)
- **Загрузка**: UEFI (EFI)

### modules/system/

| Файл | Описание |
|------|----------|
| `boot.nix` | systemd-boot, запись EFI-переменных |
| `locale.nix` | Часовой пояс Asia/Baku, раскладки US/RU, переключение Alt+Shift |
| `networking.nix` | Имя хоста `nixos`, NetworkManager |

### modules/hardware/nvidia.nix

Проприетарный драйвер NVIDIA:
- Modesetting для Wayland
- Поддержка 32-битной графики (Steam, Wine)
- Управление питанием (suspend/hibernate/resume)
- Open kernel modules
- Бета-версия драйвера для лучшей совместимости с Wayland
- Сохранение VRAM при приостановке (`NVreg_PreserveVideoMemoryAllocations=1`)

### modules/desktop/common.nix

Общие компоненты рабочего стола:
- **PipeWire** — аудио с поддержкой ALSA и PulseAudio
- **Polkit** — диалоги повышения привилегий
- **Шрифты**: JetBrains Mono Nerd Font, Noto Sans/Serif, Noto Color Emoji
- **XDG Portals** — файловые диалоги, захват экрана

### modules/desktop/stylix.nix

Тема оформления:
- **Схема**: Catppuccin Latte (светлая тема)
- **Моноширинный шрифт**: JetBrains Mono (12pt)
- **Sans-serif**: Noto Sans (11pt)
- **Курсор**: Bibata-Modern-Classic (24px)

### modules/desktop/environments/gnome/

**default.nix** — GDM + GNOME, автовход для пользователя `el`.

**home.nix** — Пользовательские пакеты и настройки:
- Blackbox Terminal, Google Chrome
- Расширения GNOME: Blur my Shell, Dash to Dock, User Themes
- Настройки dconf: прозрачность Dash to Dock (20%), отключение blur

### modules/desktop/environments/labwc/

Альтернативный легковесный Wayland-композитор:
- **Горячие клавиши**: Win+Return (терминал), Win+D (лаунчер), Win+Q (закрыть), Win+F (полный экран)
- **4 рабочих стола** (Win+1..4)
- **Тайлинг окон**: Win+стрелки
- **Панель sfwbar**: воркспейсы, системный трей, часы
- **Инструменты**: Foot (терминал), Fuzzel (лаунчер), Mako (уведомления), Thunar (файлы)
- **Дисплей**: 1920x1080 @ 240Hz (DP-3)

### modules/users/el/

**default.nix** — Пользователь `el`:
- Оболочка: Zsh
- Группы: networkmanager, wheel, video, audio, docker

**home.nix** — Home Manager:
- **Пакеты**: fastfetch, htop, PopAI
- **Git**: Elkhan Aliyev (elkhan.aliyev.91@gmail.com), ветка по умолчанию — main
- **Zsh**: Oh-My-Zsh с темой robbyrussell, плагины git/sudo/docker
- **GTK**: иконки Papirus-Dark
- **Firefox**: поддержка userChrome.css, GNOME-тема через Stylix

### modules/dev.nix

Инструменты разработки:
- **VCS**: git, gh (GitHub CLI)
- **Редакторы**: vim, VS Code, Cursor
- **AI**: Claude Code, Aider, Qwen Code, Gemini CLI, CrewAI
- **Автоматизация**: n8n
- **Виртуализация**: QEMU, Quickemu

### modules/services/mariadb.nix

MariaDB: сервис включён, данные в `/var/lib/mysql`.

### modules/virtualisation/

| Файл | Описание |
|------|----------|
| `docker.nix` | Docker с автоочисткой, драйвер хранилища btrfs |
| `waydroid.nix` | Waydroid — эмуляция Android |

## Системные характеристики

| Параметр | Значение |
|----------|----------|
| Архитектура | x86_64-linux |
| CPU | Intel (KVM) |
| GPU | NVIDIA (проприетарный драйвер) |
| Файловая система | Btrfs (zstd, subvolumes) |
| Загрузчик | systemd-boot (UEFI) |
| Рабочий стол | GNOME + GDM (Wayland) |
| Аудио | PipeWire |
| Тема | Catppuccin Latte |
| Оболочка | Zsh + Oh-My-Zsh |
| Хост | nixos |
| Пользователь | el (автовход) |
| Часовой пояс | Asia/Baku |
| Клавиатура | US/RU (Alt+Shift) |
