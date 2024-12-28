{
  config,
  pkgs,
  lib,
  ...
}: {
  options.obsidian.enable = lib.mkEnableOption "Enables Obsidian.md";

  config = lib.mkIf config.obsidian.enable {
    environment.systemPackages = with pkgs; [obsidian];
  };
}
