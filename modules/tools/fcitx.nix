{ config, lib, pkgs, ... }: {
  options.fcitx.enable = lib.mkEnableOption "Enables Fcitx5, an input method";

  config = lib.mkIf config.fcitx.enable {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;

      fcitx5 = {
        waylandFrontend = true;

        settings = {
          #globalOptions = {
          #"Vertical Candidate List" = true;

          #WheelForPaging = true;

          #"Font" = "JetBrainsMono Nerd Font Demi-Bold 10";
          #MenuFont = "JetBrainsMono Nerd Font Demi-Bold 10";
          #TrayFont = "JetBrainsMono Nerd Font Demi-Bold 10";

          #PreferTextIcon = true;

          #UseInputMethodLanguageToDisplayText = true;

          #Theme = "Material-Color-black";
          #};

          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "pinyin";

            };

            "Groups/0/Items/0" = {
              Name = "keyboard-us";
              Layout = "";
            };

            "Groups/0/Items/1" = {
              Name = "pinyin";
              Layout = "";
            };

            GroupOrder."0" = "Default";
          };
        };

        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-chinese-addons
          fcitx5-configtool
          fcitx5-material-color
        ];
      };
    };

    services.xserver.desktopManager.runXdgAutostartIfNone = true;
  };
}
