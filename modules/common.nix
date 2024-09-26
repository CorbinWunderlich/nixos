{ lib, config, pkgs, ... }: {
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ wget neovim git htop ];
  environment.etc = {
    "xdg/gtk-3.0/settings.ini".text = "gtk-application-prefer-dark-theme = TRUE";
    "xdg/gtk-4.0/settings.ini".text = "gtk-application-prefer-dark-theme = TRUE";
  };
}
