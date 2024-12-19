{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.hyprpaper.enable = lib.mkEnableOption "Enables Hyprpaper";

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper.enable = true;

    services.hyprpaper.settings = {
      preload = ["/home/corbin/Pictures/wallpapers/cities/cloudy_city.png"];
      wallpaper = [",/home/corbin/Pictures/wallpapers/cities/cloudy_city.png"];
    };
  };
}
