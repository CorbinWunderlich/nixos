{
  pkgs,
  lib,
  config,
  ...
}: {
  options.vesktop.enable = lib.mkEnableOption "Enables Vesktop";

  config = lib.mkIf config.vesktop.enable {
    environment.systemPackages = with pkgs; [vesktop];
  };
}
