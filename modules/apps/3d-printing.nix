{
  config,
  lib,
  pkgs,
  ...
}: {
  options.bambu-studio.enable = lib.mkEnableOption "Enables Bambu Studio slicer and other 3d printing utilities";

  config = lib.mkIf config.bambu-studio.enable {
    environment.systemPackages = with pkgs; [bambu-studio];
  };
}
