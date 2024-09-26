{ config, lib, pkgs, ... }: {
  options.bottles.enable = lib.mkEnableOption "Enables Bottles";

  config = lib.mkIf config.bottles.enable {
    environment.systemPackages = with pkgs; [ bottles ];
  };
}
