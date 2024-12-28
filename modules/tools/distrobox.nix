{
  config,
  lib,
  pkgs,
  ...
}: {
  options.distrobox.enable = lib.mkEnableOption "Enables Distrobox and Docker";

  config = lib.mkIf config.distrobox.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [distrobox];
  };
}
