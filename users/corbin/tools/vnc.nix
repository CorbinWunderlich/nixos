{ pkgs, lib, config, ... }: {
  options.vnc.enable = lib.mkEnableOption "Enables TigerVNC and noVNC";

  config = lib.mkIf config.vnc.enable {
    home.packages = with pkgs; [
      xorg.xinit
      tigervnc
      novnc
    ];

    systemd.user.services.vnc = {
      Unit.Description = "Runs a TigerVNC server with noVNC as the viewer.";

      Install = {
        wantedBy = [ "multi-user.target" ];
	after = [ "graphical.target" ];
      };

      Service.ExecStart = "${pkgs.writeShellScript "vnc-0" ''
        ${pkgs.tigervnc}/bin/x0vncserver -display :0 -PasswordFile ~corbin/.vnc/passwd &
	${pkgs.novnc}/bin/novnc --vnc localhost:5900
      ''}";
    };
  };
}
