{
  config,
  lib,
  ...
}: {
  options.bluetooth.enable = lib.mkEnableOption "Enables bluetooth and blueman";

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings.General.Experimental = true;
    };

    services.blueman.enable = true;
  };
}
