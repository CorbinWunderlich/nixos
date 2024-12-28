{ config, pkgs, lib, ... }: {
  imports = [ ./x.nix ];

  options = { i3.enable = lib.mkEnableOption "Enables i3wm"; };

  config = lib.mkIf config.i3.enable {
    x.enable = true;

    programs.dconf.enable = true;

    services.displayManager.autoLogin = {
      enable = false;
      user = "corbin";
    };

    environment.pathsToLink = [ "/libexec" ];

    services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher most people use
        i3status # gives you the default i3 status bar
        nitrogen # wallpaper setter
      ];
    };
  };
}
