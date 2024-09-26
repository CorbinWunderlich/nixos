{ config, lib, pkgs, ... }: {
  options.btrfs-assistant.enable = lib.mkEnableOption "Enables BTRFS Assistant";

  config = lib.mkIf config.btrfs-assistant.enable {
    environment.systemPackages = with pkgs; [ btrfs-assistant ];
  };
}
