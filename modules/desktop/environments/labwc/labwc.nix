{ ... }:

{
  xdg.configFile."labwc/rc.xml".text = ''
    <?xml version="1.0"?>
    <labwc_config>
      <core>
        <gap>4</gap>
      </core>

      <!-- Snapping configuration -->
      <snapping>
        <range>20</range>
        <overlay>
          <enabled>true</enabled>
          <delay inner="0" outer="0"/>
        </overlay>
      </snapping>

      <keyboard>
        <!-- Terminal -->
        <keybind key="W-Return">
          <action name="Execute"><command>foot</command></action>
        </keybind>

        <!-- App launcher -->
        <keybind key="W-d">
          <action name="Execute"><command>fuzzel</command></action>
        </keybind>

        <!-- Close window -->
        <keybind key="W-q">
          <action name="Close"/>
        </keybind>

        <!-- Toggle fullscreen -->
        <keybind key="W-f">
          <action name="ToggleFullscreen"/>
        </keybind>

        <!-- Toggle maximize -->
        <keybind key="W-m">
          <action name="ToggleMaximize"/>
        </keybind>

        <!-- Iconify (minimize) -->
        <keybind key="W-i">
          <action name="Iconify"/>
        </keybind>

        <!-- Screenshot region -->
        <keybind key="Print">
          <action name="Execute">
            <command>sh -c 'grim -g "$(slurp)" - | swappy -f -'</command>
          </action>
        </keybind>

        <!-- Screenshot full screen -->
        <keybind key="W-Print">
          <action name="Execute">
            <command>sh -c 'grim - | swappy -f -'</command>
          </action>
        </keybind>

        <!-- Exit session -->
        <keybind key="W-S-e">
          <action name="Exit"/>
        </keybind>

        <!-- Window switching -->
        <keybind key="A-Tab">
          <action name="NextWindow"/>
        </keybind>
        <keybind key="A-S-Tab">
          <action name="PreviousWindow"/>
        </keybind>

        <!-- Workspace switching -->
        <keybind key="W-1"><action name="GoToDesktop"><to>1</to></action></keybind>
        <keybind key="W-2"><action name="GoToDesktop"><to>2</to></action></keybind>
        <keybind key="W-3"><action name="GoToDesktop"><to>3</to></action></keybind>
        <keybind key="W-4"><action name="GoToDesktop"><to>4</to></action></keybind>

        <!-- Move window to workspace -->
        <keybind key="W-S-1"><action name="SendToDesktop"><to>1</to></action></keybind>
        <keybind key="W-S-2"><action name="SendToDesktop"><to>2</to></action></keybind>
        <keybind key="W-S-3"><action name="SendToDesktop"><to>3</to></action></keybind>
        <keybind key="W-S-4"><action name="SendToDesktop"><to>4</to></action></keybind>

        <!-- Reconfigure -->
        <keybind key="W-S-r">
          <action name="Reconfigure"/>
        </keybind>

        <!-- Media keys -->
        <keybind key="XF86AudioRaiseVolume">
          <action name="Execute"><command>wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+</command></action>
        </keybind>
        <keybind key="XF86AudioLowerVolume">
          <action name="Execute"><command>wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-</command></action>
        </keybind>
        <keybind key="XF86AudioMute">
          <action name="Execute"><command>wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle</command></action>
        </keybind>
        <keybind key="XF86AudioMicMute">
          <action name="Execute"><command>wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle</command></action>
        </keybind>
        <keybind key="XF86AudioPlay">
          <action name="Execute"><command>playerctl play-pause</command></action>
        </keybind>
        <keybind key="XF86AudioPause">
          <action name="Execute"><command>playerctl play-pause</command></action>
        </keybind>
        <keybind key="XF86AudioNext">
          <action name="Execute"><command>playerctl next</command></action>
        </keybind>
        <keybind key="XF86AudioPrev">
          <action name="Execute"><command>playerctl previous</command></action>
        </keybind>

        <!-- Brightness (if laptop) -->
        <keybind key="XF86MonBrightnessUp">
          <action name="Execute"><command>brightnessctl set +5%</command></action>
        </keybind>
        <keybind key="XF86MonBrightnessDown">
          <action name="Execute"><command>brightnessctl set 5%-</command></action>
        </keybind>

        <!-- Window tiling shortcuts -->
        <keybind key="W-Left">
          <action name="SnapToEdge"><direction>left</direction></action>
        </keybind>
        <keybind key="W-Right">
          <action name="SnapToEdge"><direction>right</direction></action>
        </keybind>
        <keybind key="W-Up">
          <action name="SnapToEdge"><direction>up</direction></action>
        </keybind>
        <keybind key="W-Down">
          <action name="SnapToEdge"><direction>down</direction></action>
        </keybind>
      </keyboard>

      <mouse>
        <default />
        <doubleClickTime>300</doubleClickTime>
        <!-- Double-click titlebar to maximize, scroll to shade -->
        <context name="TitleBar">
          <mousebind button="Left" action="DoubleClick">
            <action name="ToggleMaximize"/>
          </mousebind>
          <mousebind button="Up" action="Scroll">
            <action name="ToggleShade"/>
          </mousebind>
          <mousebind button="Down" action="Scroll">
            <action name="ToggleShade"/>
          </mousebind>
        </context>
        <!-- Win+drag anywhere to move/resize -->
        <context name="Frame">
          <mousebind button="W-Left" action="Drag">
            <action name="Move"/>
          </mousebind>
          <mousebind button="W-Right" action="Drag">
            <action name="Resize"/>
          </mousebind>
        </context>
        <context name="Client">
          <mousebind button="W-Left" action="Drag">
            <action name="Move"/>
          </mousebind>
          <mousebind button="W-Right" action="Drag">
            <action name="Resize"/>
          </mousebind>
        </context>
      </mouse>

      <libinput>
        <device category="default">
          <naturalScroll>no</naturalScroll>
          <accelProfile>flat</accelProfile>
        </device>
      </libinput>

      <desktops>
        <number>4</number>
        <names>
          <name>1</name>
          <name>2</name>
          <name>3</name>
          <name>4</name>
        </names>
        <popupTime>500</popupTime>
      </desktops>
    </labwc_config>
  '';

  xdg.configFile."labwc/menu.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <openbox_menu>
      <menu id="client-menu" label="Window">
        <item label="Maximize"><action name="ToggleMaximize"/></item>
        <item label="Minimize"><action name="Iconify"/></item>
        <item label="Fullscreen"><action name="ToggleFullscreen"/></item>
        <separator/>
        <item label="Always on Top"><action name="ToggleAlwaysOnTop"/></item>
        <separator/>
        <item label="Close"><action name="Close"/></item>
      </menu>
      <menu id="root-menu" label="Menu">
        <item label="Terminal"><action name="Execute"><command>foot</command></action></item>
        <item label="Browser"><action name="Execute"><command>firefox</command></action></item>
        <item label="Files"><action name="Execute"><command>thunar</command></action></item>
        <separator/>
        <item label="Reconfigure"><action name="Reconfigure"/></item>
        <item label="Exit"><action name="Exit"/></item>
      </menu>
    </openbox_menu>
  '';

  xdg.configFile."labwc/autostart".text = ''
    # Set 240Hz refresh rate
    wlr-randr --output DP-3 --mode 1920x1080@239.759995Hz &

    # Wallpaper
    swaybg -i ~/nixos-config/wallpapers/wallpaper.png -m fill &

    # Polkit agent
    /run/current-system/sw/libexec/polkit-gnome-authentication-agent-1 &

    # Notifications
    mako &

    # Status bar
    sfwbar &

    # Dock
    crystal-dock &

    # Idle management - suspend after 10 min
    swayidle -w timeout 600 'systemctl suspend' before-sleep 'playerctl pause' &
  '';
}
