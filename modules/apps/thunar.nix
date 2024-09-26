{ config, lib, pkgs, ... }: {
  options.thunar.enable = lib.mkEnableOption "Enables Thunar";

  config = lib.mkIf config.thunar.enable {
    programs.thunar.enable = true;
    services.tumbler.enable = true;
  };
}
