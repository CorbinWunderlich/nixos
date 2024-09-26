{ config, lib, pkgs, ... }: {
  options.i3.enable = lib.mkEnableOption "Enables i3";

  config = lib.mkIf config.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };
  };
}
