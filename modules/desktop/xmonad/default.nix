{ config, lib, pkgs, protocol, ... }:

{
  config = lib.mkIf ( protocol == "X" ) {
    programs.dconf.enable = true;

    services = {
      xserver = {
        enable = true;

        layout = "us";
        xkbOptions = "eurosign:e";

        displayManager = {
          lightdm = {
            enable = true;
            background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
            greeters = {
              gtk = {
                theme = {
                  name = "Dracula";
                  package = pkgs.dracula-theme;
                };
                cursorTheme = {
                  name = "Dracula-cursors";
                  package = pkgs.dracula-theme;
                  size = 16;
                };
              };
            };
          };
          defaultSession = "none+xmonad";
        };

        windowManager= {
          xmonad = {
            enable = true;
            enableContribAndExtras = true;
            #config = ./xmonad/xmonad.hs;
          };
        };

        videoDrivers = [
          "intel"
        ];

        # displayManager.sessionCommands = ''
        #   #!/bin/sh
        #   SCREEN=$(${pkgs.xorg.xrandr}/bin/xrandr | grep " connected " | wc -l)
        #   if [[ $SCREEN -eq 1 ]]; then
        #     ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --primary --mode 1920x1080 --rotate normal
        #   elif [[ $SCREEN -eq 2 ]]; then
        #     ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --primary --mode 1920x1080 --rotate normal --output DisplayPort-1 --mode 1920x1080 --rotate normal --left-of HDMI-A-1
        #   elif [[ $SCREEN -eq 3 ]]; then
        #     ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --primary --mode 1920x1080 --rotate normal --output DisplayPort-1 --mode 1920x1080 --rotate normal --left-of HDMI-A-1 --output HDMI-A-0 --mode 1280x1024 --rotate normal --right-of HDMI-A-1
        #   fi
        # '';

        serverFlagsSection = ''
          Option "BlankTime" "0"
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
        '';

        # Used so computer does not goes to sleep
        resolutions = [
          { x = 1920; y = 1080; }
          { x = 1600; y = 900; }
          { x = 3840; y = 2160; }
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      xclip
      xorg.xev
      xorg.xkill
      xorg.xrandr
    ];
  };
}
