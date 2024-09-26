{ config, pkgs, lib, ... }: {
  options.kitty.enable =
    lib.mkEnableOption "Enables the Kitty terminal emulator";

  config = lib.mkIf config.kitty.enable {
    fonts.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

    environment.systemPackages = [ pkgs.kitty ];
  };
}
