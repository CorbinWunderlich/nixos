{ pkgs, lib, config, ... }: {
  options.neovim.enable = lib.mkEnableOption "Enables Neovim";

  config = lib.mkIf config.neovim.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      nil
      nixfmt-classic
      stylua
      ripgrep
      fzf
      nodejs
      cargo
      libgcc
    ];

    programs.neovim = {
      enable = true;

      vimAlias = true;
      viAlias = true;

      defaultEditor = true;
    };
  };
}
