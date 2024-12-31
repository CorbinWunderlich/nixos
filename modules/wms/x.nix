{
  config,
  lib,
  ...
}: {
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

    services.libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
      };

      touchpad = {
        accelProfile = "flat";
        transformationMatrix = "1 0 0 0 1 0 0 0 0.45";
      };
    };
  };
}
