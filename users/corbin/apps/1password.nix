{ pkgs, lib, config, ... }: {
  options.passwordmanager.enable = lib.mkEnableOption "Enables 1password";

  config = lib.mkIf config.passwordmanager.enable {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        IdentityAgent ~/.1password/agent.sock
      '';
    };

    xdg.configFile."1Password/ssh/agent.toml".text = ''
      [[ssh-keys]]
      vault = "Private"

      [[ssh-keys]]
      vault = "Corbin"
    '';
  };
}
