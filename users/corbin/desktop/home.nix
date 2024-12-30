{...}: {
  imports = [../modules.nix];

  machine.type = "desktop"; # Result of hostnamectl chassis

  home = {
    username = "corbin";
    homeDirectory = "/home/corbin";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
