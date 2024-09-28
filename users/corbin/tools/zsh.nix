{ pkgs, lib, config, ... }:
let
  zshrc = ''
    bindkey "''${key[Up]}" up-line-or-search
    PROMPT="%~ at %T"$'\n'"❯ "
  '';
in {
  options.zsh.enable = lib.mkEnableOption "Enables ZSH";

  config = lib.mkIf config.zsh.enable {
    home.packages = with pkgs; [
      zsh-autocomplete
      zsh-autosuggestions
      zsh-vi-mode
    ];

    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;

      shellAliases = {
        ll = "ls -l";
        grim = "grimblast";
        "sudo nvim ." = "sudo -Es nvim .";
        "sudo nvim /etc/nixos" = "sudo -Es nvim /etc/nixos";
      };

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      plugins = [
        {
          name = "zsh-autocomplete";
          src = pkgs.fetchFromGitHub {
            owner = "marlonrichert";
            repo = "zsh-autocomplete";
            rev = "24.09.04";
            sha256 = "sha256-o8IQszQ4/PLX1FlUvJpowR2Tev59N8lI20VymZ+Hp4w=";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "0.7.0";
            sha256 = "sha256-o8IQszQ4/PLX1FlUvJpowR2Tev59N8lI20VymZ+Hp4w=";
          };
        }
        {
          name = "zsh-vi-mode";
          src = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "v0.11.0";
            sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
          };
        }
      ];

      initExtra = zshrc;
    };
  };
}
