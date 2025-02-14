{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.neovim.enable = lib.mkEnableOption "Enables Neovim";

  config = lib.mkIf config.neovim.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      alejandra
      ripgrep
      fzf
      inputs.nixvim.packages.x86_64-linux.default
    ];
  };
}
