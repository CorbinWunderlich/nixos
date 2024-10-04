{ config, lib, pkgs, ... }:
let modifier = config.xsession.windowManager.i3.config.modifier;
in {
  options.i3.enable = lib.mkEnableOption "Enables i3";

  config = lib.mkIf config.i3.enable {
    home.packages = with pkgs; [ autotiling ];

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3;

      config = {
        modifier = "Mod1";

        terminal = "kitty";

        fonts = {
          names = [ "Inter" ];
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

        startup = [{
          command = "${pkgs.autotiling}/bin/autotiling -w 1 3 5 7 9";
          always = true;
        }];

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

        "tztime local" = {
          position = 2;
          settings.format = "%H:%M:%S";
        };

        "ipv6".enable = false;
        "wireless _first_".enable = false;
        "ethernet _first_".enable = false;
        "battery all".enable = false;
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
  };
}
