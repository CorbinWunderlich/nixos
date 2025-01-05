{
  config,
  lib,
  pkgs,
  ...
}: {
  options.remmina.enable = lib.mkEnableOption "Enables Remmina, a RDP client";

  config = lib.mkIf config.remmina.enable {
    environment.systemPackages = with pkgs; [remmina];
  };
}
