{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mission-center.enable = lib.mkEnableOption "Enables Mission Center";

  config = lib.mkIf config.bottles.enable {
    environment.systemPackages = with pkgs; [mission-center];
  };
}
