import XMonad

--  Hooks
import XMonad.Hooks.EwmhDesktops

-- Utilities
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:RobotoMono Nerd Font:regular:size=12:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

main :: IO ()
main = do
    xmproc <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/xmobarrc")

    xmonad $ def
        { modMask = myModMask
        , terminal = myTerminal
        }
