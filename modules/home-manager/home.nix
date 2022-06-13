{ config, pkgs, lib, ... }:

{

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  xdg = {
    enable = true; # Enable xdg explicitly
    userDirs.createDirectories = true;
  };

  programs = {
    autorandr.enable = true;

    keychain = {
      enable = true;
      enableXsessionIntegration = true;
      enableZshIntegration = true;
    };
  };

  home = {
    keyboard = null;

    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      size = 16;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  xsession = {
    enable = true;
    numlock.enable = true;

    windowManager.bspwm = {
      enable = true;
      extraConfig = ''
        ${builtins.readFile (../../configuration/bspwmrc)}

        feh --bg-scale ${../../wallpaper/wallpaper.png} &
        xset r rate 200 30 &
        easyeffects --gapplication-service &
        exec $HOME/.nix-profile/libexec/polkit-gnome-authentication-agent-1 &
      '';
    };
  };

  xresources.extraConfig = ''
    ${builtins.readFile (
        pkgs.fetchFromGitHub {
          owner = "arcticicestudio";
          repo = "nord-xresources";
          rev = "v0.1.0";
          sha256 = "1bhlhlk5axiqpm6l2qaij0cz4a53i9hcfsvc3hw9ayn75034xr93";
        } + "/src/nord"
      )}
  '';

  gtk = {
    enable = true;

    theme = {
      package = pkgs.nordic;
      name = "Nordic-darker";
    };

    font = {
      name = "Noto Sans";
      size = 10;
    };

    iconTheme = {
      package = pkgs.luna-icons;
      name = "Luna-Dark";
    };
  };

  services = {
    playerctld.enable = true;
    network-manager-applet.enable = true;

    redshift = {
      enable = true;
      provider = "geoclue2";
    };

    betterlockscreen = {
      enable = true;
      inactiveInterval = 10;
    };

    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };

    gnome-keyring = {
      enable = true;
      components = ["secrets" "pkcs11" "ssh"];
    };

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gtk2";
    };

    polybar = {
      enable = true;
      package = pkgs.polybarFull;
      config = ../../configuration/config.ini;
      script = "polybar main &";

      extraConfig = ''
        [bar/main]
        modules-left = bspwm sep title
        modules-center =
        modules-right = volume sep time sep
      '';
    };

    picom = {
      enable = true;
      blur = true;
      shadow = false;
      vSync = false;
      backend = "xr_glx_hybrid";

      fade = true; # Effects
      fadeDelta = 3;
      fadeSteps = [ "0.028" "0.03" ];

      opacityRule = [
      "97:class_g = 'Alacritty'"
      "99:class_g = 'Spotify'"
      "99:class_g = 'discord'"
      "99:class_g = 'Code'"
      "98:class_g = 'GitHub Desktop'"
      "98:class_g = 'Thunar'"
      ];
    };

    sxhkd = {
      enable = true;

      keybindings = {
        # Terminal
        "super + Return" = "alacritty";

        # Focus options
        "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}"; # Switch window directly
        "super + {_,shift + } Tab" = "bspwc node -f {next.local,prev.local}"; # Switch focus chronologically

        # Window options
        "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}"; # Move window
        "alt + shift + {h,j,k,l}" = "bspc node -v {-20 0,0 20,0 -20,20 0}"; # Move floating window
        "super + alt + {h,l,k,j}" = "bspc node -z {left 20 0,right -20 0,top 0 20,bottom 0 -20}"; # Shrink window
        "super + control + {h,l,k,j}" = "bspc node -z {left -20 0,right 20 0,top 0 -20,bottom 0 20}"; # Expand window
        "super + c" = "bspc node -c"; # Close window

        # Automatic layout
        "super + f" = "bspc desktop -l next"; # Toggle monocle
        "super + space" = "bspc node -t '~'{floating,tiled}"; # Toggle float and tile
        "super + {p,t}" = "bspc node -t {pseudo_tiled,tiled}"; # Switch tile and pseudo tile

        # Manual layout
        "super + {Up,Down,q}" = "bspc node -p {east,south,cancel}"; # Specify direction
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}"; # Specify ratio

        # Workspace
        "super + {1,2,3,8,9,0,ssharp}" = "bspc desktop -f '^{1,2,3,4,5,6,7}'"; # Switch workspace directly
        "ctrl + alt + {h,l}" = "bspc desktop -f {prev.local,next.local}"; # Switch workspace in order
        "super + shift + {1,2,3,8,9,0,ssharp}" = "bspc node -d '^{1,2,3,4,5,6,7}'"; # Window --> Workspace

        # Rofi
        "super + BackSpace" = "rofi -show drun"; # Application menu
        "alt + Tab" = "rofi -show window";
        "super + shift + f" = "rofi -show filebrowser";
        "super + shift + c" = "rofi -show calc";

        # Dunst
        "super + shift + o" = "dunstctl history-pop";
        "super + shift + p" = "dunstctl close";

        # Volume keys
        "XF86AudioMute" = "pamixer -t";
        "XF86AudioRaiseVolume" = "pamixer -i 5";
        "XF86AudioLowerVolume" = "pamixer -d 5";

        # Backlight
        "XF86MonBrightnessUp" = "brightnessctl set +5%";
        "XF86MonBrightnessDown" = "brightnessctl set 5%-";

        # Media keys for spotify
        "XF86AudioPlay" = "playerctl play-pause";
        "XF86AudioPrev" = "playerctl previous";
        "XF86AudioNext" = "playerctl next";

        # Screenshot
        "super + Print" = "scrot '%d.%m.%Y_$wx$h.png' -e 'mv $f ~/Bilder/'";
        "alt + Print" = "scrot -u '%d.%m.%Y_$wx$h.png' -e 'mv $f ~/Bilder/'";

        # Debug options
        "ctrl + alt + r" = "systemctl --user restart polybar.service";
        "ctrl + alt + q" = "xkill";
      };
    };

    dunst = {
      enable = true;

      iconTheme = {
        package = pkgs.luna-icons;
        name = "Luna-Dark";
        size = "16x16";
      };

      settings = {
        global = {
          monitor = 0;
          follow = "none";

          width = 400;
          height = 300;

          origin = "top-right";
          offset = "6x33";

          indicate_hidden = "yes";

          shrink = "no";

          transparency = 0;
          notification_height = 120;

          separator_height = 0;

          padding = 20;
          horizontal_padding = 10;

          frame_width = 2;
          frame_color = "#434C5E";
          corner_radius = 2;
          separator_color = "frame";

          sort = "yes";
          idle_threshold = 120;

          font = "BitstreamVeraSansMono Nerd Font Regular 14";
          line_height = 0;

          markup = "full";
          format = "<b>%s</b>\n%b";

          alignment = "left";
          vertical_alignment = "center";

          show_age_threshold = 60;

          word_wrap = "yes";
          ellipsize = "middle";
          ignore_newline = "yes";

          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = "yes";

          icon_position = "left";
          max_icon_size = 72;

          sticky_history = "yes";
          history_length = 20;

          # dmenu = /usr/bin/dmenu -p dunst:
          # browser = /usr/bin/sensible-browser

          always_run_script = true;

          title = "Dunst";
          class = "Dunst";

          startup_notification = false;
          verbosity = "mesg";
          force_xinerama = false;

          mouse_left_click = "close_current";
          mouse_middle_click = "do_action";
          mouse_right_click = "close_all";
        };

        urgency_low = {
          background = "#2E3440";
          foreground = "#E5E9F0";
          timeout = 5;
        };

        urgency_normal = {
          background = "#2E3440";
          foreground = "#E5E9F0";
          timeout = 8;
        };

        urgency_critical = {
          background = "#81A1C1";
          foreground = "#A5A5A5";
          timeout = 0;
        };
      };
    };
  };
}
