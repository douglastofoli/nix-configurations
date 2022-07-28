#
#  Home-manager configuration for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │       └─ ./home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./bspwm
#               └─ home.nix
#

{ lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/xmonad/home.nix  # Window Manager
    ];

  home = {                                # Specific packages for desktop
    packages = with pkgs; [
      # Applications
      gimp
      
      # Imported in default config
      #bazarr           # Subtitles
      #discord          # Comms           # See overlay default.nix
      #ffmpeg           # Video Support
      #gphoto2          # Digital Photography
      #handbrake        # Encoder
      #radarr           # Media Movies    # See services/media.nix for radarr, sonarr and bazarr
      #shotwell         # Raw Photo Manager
      #sonarr           # Media TV Shows
      #steam            # Game Launcher

      # Future
      #MKVtoolnix
    ];
  };

  services = {                            # Applets
    blueman-applet.enable = true;         # Bluetooth
  };

  config = lib.mkIf (config.xsession.enable) {             # Only evaluate code if using X11
    services.picom = {
      enable = true;
      package = pkgs.picom.overrideAttrs(o: {
        src = pkgs.fetchFromGitHub {
          #repo = "picom";
          #owner = "pijulius";
          #rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
          #sha256 = "YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
          repo = "picom";
          owner = "ibhagwan";
          #rev = "e3c19cd7d1108d114552267f302548c113278d45";
          sha256 = "4voCAYd0fzJHQjJo4x3RoWz5l3JJbRvgIXn1Kg6nz6Y=";
        };
      });                                           # Override picom to use pijulius' version

      backend = "glx";                              # Rendering either with glx or xrender. You'll know if you need to switch this.
      vSync = true;                                 # Should fix screen tearing

      activeOpacity = "0.93";                       # Node transparency
      inactiveOpacity = "0.93";
      menuOpacity = "0.93";

      shadow = false;                               # Shadows
      shadowOpacity = "0.75";
      fade = true;                                  # Fade
      fadeDelta = 10;
      opacityRule = [                               # Opacity rules if transparency is prefered
        "100:name = 'Picture in picture'"
        "100:name = 'Picture-in-Picture'"
        "85:class_i ?= 'rofi'"
        "80:class_i *= 'discord'"
        "80:class_i *= 'emacs'"
        "80:class_i *= 'Alacritty'"
        "100:fullscreen"
      ];                                            # Find with $ xprop | grep "WM_CLASS"

      extraOptions = ''
      '';                                           # Extra options for picom.conf (mostly for pijulius fork)
    };
  };
}
