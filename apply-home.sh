#!/bin/sh

nix build .#homeConfigurations.pacman.activationPackage
./result/activate
