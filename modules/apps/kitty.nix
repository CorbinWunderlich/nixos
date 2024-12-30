{
  config,
  pkgs,
  lib,
  ...
}: {
  options.kitty.enable =
    lib.mkEnableOption "Enables the Kitty terminal emulator";

  config = lib.mkIf config.kitty.enable {
    fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono];

    environment.systemPackages = [pkgs.kitty];

    environment.sessionVariables = {
      GLFW_IM_MODULE = "ibus";
    };
  };
}
