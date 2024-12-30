{
  config,
  lib,
  pkgs,
  ...
}: let
  modifier = config.xsession.windowManager.i3.config.modifier;
in {
  options.i3.enable = lib.mkEnableOption "Enables i3";

  config = lib.mkIf config.i3.enable {
    home.packages = with pkgs; [autotiling];

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3;

      config = {
        modifier = "Mod1";

        terminal = "kitty";

        fonts = {
          names = ["Inter"];
          style = "SemiBold";
          size = 11.0;
        };

        window = {
          border = 2;
          titlebar = false;
          hideEdgeBorders = "smart";
        };

        floating = {
          border = 2;
          titlebar = false;
        };

        startup = [
          {
            command = "${pkgs.autotiling}/bin/autotiling";
            always = true;
          }
          {
            command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &";
            always = true;
          }
        ];

        defaultWorkspace = "workspace number 1";

        keybindings = lib.mkOptionDefault {
          "${modifier}+ctrl+1" = "workspace number 1";
          "${modifier}+ctrl+2" = "workspace number 2";
          "${modifier}+ctrl+3" = "workspace number 3";
          "${modifier}+ctrl+4" = "workspace number 4";
          "${modifier}+ctrl+5" = "workspace number 5";
          "${modifier}+ctrl+6" = "workspace number 6";
          "${modifier}+ctrl+7" = "workspace number 7";
          "${modifier}+ctrl+8" = "workspace number 8";
          "${modifier}+ctrl+9" = "workspace number 9";
          "${modifier}+ctrl+0" = "workspace number 10";
        };
      };
    };

    programs.i3status = {
      enable = true;

      general = {
        colors = true;
        interval = 5;
      };

      modules = {
        "cpu_usage" = {
          position = 1;
          settings.format = "%usage";
        };

        "battery all" = {
          position = 2;
          enable = config.machine.type == "laptop";
          settings = {
            format = "%percentage %status";
            format_percentage = "%.0f%s";
            status_chr = "and charging";
            status_bat = "on battery";
            status_unk = "";
            status_full = "";
            status_idle = "";
            last_full_capacity = true;
          };
        };

        "tztime local" = {
          position = 3;
          settings.format = "%H:%M:%S";
        };

        "ipv6".enable = false;
        "wireless _first_".enable = false;
        "ethernet _first_".enable = false;
        "disk /".enable = false;
        "load".enable = false;
        "memory".enable = false;
      };
    };

    xdg.configFile."nitrogen/nitrogen.cfg".text = ''
      [geometry]
      posx=680
      posy=554
      sizex=676
      sizey=191

      [nitrogen]
      view=icon
      recurse=true
      sort=alpha
      icon_caps=false
      dirs=/home/corbin/Pictures/wallpapers;
    '';

    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };
  };
}
