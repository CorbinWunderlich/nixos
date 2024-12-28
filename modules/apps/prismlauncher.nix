{
  config,
  lib,
  pkgs,
  ...
}: {
  options.prismlauncher.enable = lib.mkEnableOption "Enables PrismLauncher";

  config = lib.mkIf config.prismlauncher.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher

      jre8
      jetbrains.jdk-no-jcef-17
      jetbrains.jdk
    ];
  };
}
