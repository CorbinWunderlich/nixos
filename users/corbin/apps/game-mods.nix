{
  lib,
  config,
  pkgs,
  ...
}: {
  options.mods.enable = lib.mkEnableOption "Enables mods for various games";

  config = lib.mkIf config.mods.enable {
    home.packages = with pkgs; [
      ckan
    ];
  };
}
