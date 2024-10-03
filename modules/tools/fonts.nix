{ config, lib, pkgs, ... }: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    inter
    noto-fonts-cjk-sans
  ];
}
