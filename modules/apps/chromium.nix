{ config, lib, pkgs, ... }: {
  options.chromium.enable = lib.mkEnableOption "Enables Chromium";

  config = lib.mkIf config.chromium.enable {
    environment.systemPackages = with pkgs; [ chromium ];
  };
}
