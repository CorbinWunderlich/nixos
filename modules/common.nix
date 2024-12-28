{ pkgs, ... }: {
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [ wget neovim git lazygit htop ];
  programs.nix-ld.enable = true;
}
