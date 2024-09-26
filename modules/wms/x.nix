{ config, lib, pkgs, ... }: {
  options.x.enable = lib.mkEnableOption "Enables the X Windowing Server";

  config = lib.mkIf config.x.enable {
    services.xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };

      desktopManager.xterm.enable = false;
    };
  };
}
