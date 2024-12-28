{
  config,
  lib,
  pkgs,
  ...
}: {
  options.passwordmanager.enable = lib.mkEnableOption "Enables 1password";

  config = lib.mkIf config.passwordmanager.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = ["corbin"];
    };

    environment.etc."1password/custom_allowed_browsers" = {
      text = "firefox";
      mode = "0755";
    };
  };
}
