{ config, lib, pkgs, ... }: {
  options.pipewire.enable = lib.mkEnableOption "Enables Pipewire";

  config = lib.mkIf config.pipewire.enable {
    hardware.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [ pavucontrol ];
  };
}
