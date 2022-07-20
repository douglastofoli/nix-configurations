{ config, lib, pkgs, inputs, user, location, ... }:

{
  imports =                                 # Import window or display manager.
    [
     # ../modules/editors/emacs              # ! Comment this out on first install !
    ];

  users.users.${user} = {                   # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "docker" ];
    shell = pkgs.zsh;                       # Default shell
  };

  time.timeZone = "America/Sao_Paulo";        # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      LC_TIME = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br";                    # or us/azerty/etc
  };

  fonts.fonts = with pkgs; [
    cantarell-fonts
    carlito               # NixOS
    corefonts             # MS
    font-awesome          # Icons
    vegur                 # NixOS

    (nerdfonts.override { # Nerdfont Icons override
      fonts = [
        "FiraCode"
        "Iosevka"
        "JetBrainsMono"
        "RobotoMono"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "emacs";
      VISUAL = "emacs";
    };
    systemPackages = with pkgs; [           # Default packages install system-wide
      #vim
      #git
      nano
      pciutils
      usbutils
      wget
    ];
  };


  xdg.portal = {                            # Required for flatpak
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;               # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}

