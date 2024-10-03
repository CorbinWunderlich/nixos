{ pkgs, ... }: {
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ wget neovim git lazygit htop ];
  programs.nix-ld.enable = true;
}
