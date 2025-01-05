{lib, ...}: {
  imports = [
    ./wms/i3.nix
    ./wms/hyprland.nix
    ./wms/kde.nix

    ./tools/samba.nix
    ./tools/1password.nix
    ./tools/fonts.nix
    ./tools/pipewire.nix
    ./tools/pulseaudio.nix
    ./tools/btrfs-assistant.nix
    ./tools/distrobox.nix
    ./tools/sops.nix
    ./tools/printing.nix
    ./tools/xrdp.nix
    ./tools/fcitx.nix
    ./tools/bluetooth.nix

    ./apps/kitty.nix
    ./apps/steam.nix
    ./apps/firefox.nix
    ./apps/obsidian.nix
    ./apps/vesktop.nix
    ./apps/prismlauncher.nix
    ./apps/thunar.nix
    ./apps/bottles.nix
    ./apps/mission-center.nix
    ./apps/thunderbird.nix
    ./apps/chromium.nix
    ./apps/3d-printing.nix
    ./apps/remmina.nix

    ./common.nix
  ];

  i3.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault true;
  kde.enable = lib.mkDefault true;

  samba.enable = lib.mkDefault true;
  passwordmanager.enable = lib.mkDefault true;

  pulseaudio.enable = lib.mkDefault false;
  pipewire.enable = lib.mkDefault true;

  btrfs-assistant.enable = lib.mkDefault true;

  distrobox.enable = lib.mkDefault true;

  sops.enable = lib.mkDefault true;

  printing.enable = lib.mkDefault true;

  xrdp.enable = lib.mkDefault false;

  fcitx.enable = lib.mkDefault true;

  bluetooth.enable = lib.mkDefault true;

  kitty.enable = lib.mkDefault true;

  steam.enable = lib.mkDefault true;

  firefox.enable = lib.mkDefault true;

  obsidian.enable = lib.mkDefault true;

  vesktop.enable = lib.mkDefault true;

  prismlauncher.enable = lib.mkDefault true;

  thunar.enable = lib.mkDefault true;

  bottles.enable = lib.mkDefault true;

  mission-center.enable = lib.mkDefault true;

  thunderbird.enable = lib.mkDefault true;

  chromium.enable = lib.mkDefault true;

  bambu-studio.enable = lib.mkDefault true;

  remmina.enable = lib.mkDefault true;
}
