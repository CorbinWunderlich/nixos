{ config, lib, ... }: {
  options.x.enable = lib.mkEnableOption "Enables the X Windowing Server";

  config = lib.mkIf config.x.enable {
    services.xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };

      libinput = {
        enable = true;

	mouse = {
	  accelProfile = "flat";
	};

	touchpad = {
	  accelProfile = "flat";
	};
      };

      desktopManager.xterm.enable = false;
    };
  };
}
