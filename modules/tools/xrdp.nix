{
  config,
  lib,
  pkgs,
  ...
}: {
  options.xrdp.enable = lib.mkEnableOption "Enables xrdp";

  config = lib.mkIf config.xrdp.enable {
    services.xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.i3}/bin/i3";

      audio.enable = true;
    };

    security.polkit.enable = true;
  };
}
