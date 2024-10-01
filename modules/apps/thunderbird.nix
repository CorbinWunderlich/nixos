{ config, lib, pkgs, ... }: {
  options.thunderbird.enable = lib.mkEnableOption "Enables Thunderbird";

  config = lib.mkIf config.thunderbird.enable {
    environment.systemPackages = with pkgs; [ thunderbird ];
  };
}
