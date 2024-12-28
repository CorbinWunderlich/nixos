{
  config,
  lib,
  pkgs,
  ...
}: {
  options.kde.enable = lib.mkEnableOption "Enables KDE Plasma 6";

  config = lib.mkIf config.kde.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
