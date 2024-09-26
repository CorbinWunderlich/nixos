{ lib, ... }: {
  imports = [
    ./apps/1password.nix
    ./apps/kitty.nix
    ./apps/neovim.nix

    ./tools/zsh.nix
    ./tools/vnc.nix

    ./wms/i3.nix
    ./wms/hyprland.nix
    ./wms/hyprlock.nix
    ./wms/widgets/ags.nix
    ./wms/widgets/dunst.nix
  ];

  passwordmanager.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;

  zsh.enable = lib.mkDefault true;
  vnc.enable = lib.mkDefault false;

  hyprland.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  i3.enable = lib.mkDefault false;
  ags.enable = lib.mkDefault true;
  dunst.enable = lib.mkDefault true;
}
