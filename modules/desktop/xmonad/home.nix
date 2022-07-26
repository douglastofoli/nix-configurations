{ config, lib, pkgs, protocol, ... }:

{
  config = lib.mkIf (protocol == "X") {
    xsession = {
      enable = true;
      numlock.enable = true;

      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          #config = ./xmonad/xmonad.hs;
        };
      };
    };
  };
}
