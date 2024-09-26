{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./../modules/modules.nix ];

  hyprland.enable = false;
  kde.enable = false;
  i3.enable = true;

  btrfs-assistant.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixvm";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";

  programs.zsh.enable = true;

  users.users.corbin = import ./../users/corbin/corbin.nix;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [ novnc xorg.xinit tigervnc ];

  services.openssh = {
    enable = true;

    settings.PasswordAuthentication = false;
  };

  services.qemuGuest.enable = true;

  services.fstrim.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.05";
}
