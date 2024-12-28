{
  config,
  lib,
  pkgs,
  ...
}: {
  options.pipewire.enable = lib.mkEnableOption "Enables Pipewire";

  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [pavucontrol];
  };
}
