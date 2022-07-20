#
#  Services
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./services
#           └─ default.nix *
#               └─ ...
#

[
  ./flameshot.nix
  ./picom.nix
  ./pipewire.nix
]

# Media is pulled from desktop default config
