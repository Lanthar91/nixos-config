{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sfwbar
  ];

  # sfwbar configuration
  xdg.configFile."sfwbar/sfwbar.config".text = ''
# Глобальные настройки
SetWindowName "sfwbar"
SetPosition "top", "center"
SetLayer "top"
SetExclusiveZone "auto"

# Тема (Mac-ish Dark)
Define BG = "#1e1e2ecc" 
Define FG = "#cdd6f4"

# ==============================================================================
# Layout
# ==============================================================================

layout {
  # 1. Меню
  button {
    style = "launcher"
    value = " ❄️ "
    action = "wofi --show drun"
    tooltip = "Menu"
  }

  # 2. Список воркспейсов (простой пейджер)
  pager {
    style = "pager"
    rows = 1
    preview = false
  }

  # 3. Название активного окна
  label {
    style = "windowtitle"
    value = WinTitle
    trigger = "window"
  }

  # 4. РАСПОРКА (Самое важное: толкает всё остальное вправо)
  label {
    style = "spacer"
    value = ""
  }

  # 5. Правая часть
  tray {
    style = "tray"
  }

  label {
    style = "clock"
    interval = 1000
    value = Time("%H:%M")
    tooltip = Time("%A, %d %B")
  }
}

# ==============================================================================
# CSS
# ==============================================================================

CSS {
  window {
    background-color: @BG;
    font-family: "JetBrains Mono", sans-serif;
    font-size: 14px;
    /* Убираем лишние границы, чтобы не было "хаоса" */
    border-bottom: 1px solid rgba(255,255,255,0.1); 
  }

  /* Меню */
  #launcher {
    padding: 0px 10px;
    font-size: 16px;
    background: transparent;
    border: none;
    color: @FG;
  }

  /* Воркспейсы */
  #pager {
    padding: 0 10px;
    background-color: transparent;
  }
  #pager button {
    min-width: 24px;
    min-height: 24px;
    margin: 2px;
    border-radius: 4px;
    background-color: rgba(255,255,255,0.1);
    color: @FG;
    border: none;
  }
  #pager button:active {
    background-color: #89b4fa; /* Активный цвет */
    color: #1e1e2e;
  }

  /* Заголовок окна */
  #windowtitle {
    padding-left: 15px;
    color: @FG;
    font-weight: bold;
    /* Ограничиваем длину, чтобы не наезжало на часы */
    -GtkWidget-hexpand: false; 
  }

  /* МАГИЯ: Это заставляет этот пустой лейбл занять всё свободное место */
  #spacer {
    -GtkWidget-hexpand: true;
    min-height: 2px;
  }

  /* Часы */
  #clock {
    padding: 0px 15px;
    font-weight: bold;
    color: @FG;
  }

  /* Трей */
  #tray {
    padding: 0px 5px;
  }
}
  '';
}
