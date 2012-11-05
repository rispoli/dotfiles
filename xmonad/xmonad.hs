import XMonad
import qualified XMonad.StackSet as W
import XMonad.Layout.Tabbed
import XMonad.Config (defaultConfig)
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Themes
import System.IO

import qualified Data.Map as M

main :: IO ()
main = do
	xmonad $ defaultConfig {
			  terminal           = "urxvt"
			, layoutHook         = avoidStruts $ (smartBorders myTab ||| Full ||| tiled)
			, logHook            = dynamicLogXinerama
			, keys               = \c -> myKeys c `M.union` keys defaultConfig c
			, manageHook = manageHook defaultConfig <+> manageDocks
		}
		where
			myTab = tabbed shrinkText (theme smallClean)
			tiled = Tall 1 0.618034 0.03

			myKeys (XConfig {XMonad.modMask = modm}) = M.fromList $
					[ ((modm .|. shiftMask, xK_p), shellPrompt myXPConfig) ] ++

					-- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
					-- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
					[ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
						| (key, sc) <- zip [xK_e, xK_r, xK_w] [0..]
						, (f, m) <- [(W.view, 0), (W.shift, shiftMask)] ] ++

					-- multimedia keys
					[ ((0, 0x1008ff12), spawn "amixer set Master toggle") -- XF86AudioMute
					, ((0, 0x1008ff14), spawn "mpc toggle")               -- XF86AudioPlay
					, ((0, 0x1008ff15), spawn "mpc stop")                 -- XF86AudioStop
					, ((0, 0x1008ff13), spawn "mpc volume +7")            -- XF86AudioRaiseVolume
					, ((0, 0x1008ff11), spawn "mpc volume -7")            -- XF86AudioLowerVolume
					, ((0, 0x1008ff16), spawn "mpc prev")                 -- XF86AudioPrev
					, ((0, 0x1008ff17), spawn "mpc next")                 -- XF86AudioNext
					, ((0, 0x1008ff19), spawn "thunderbird")              -- XF86Mail
					, ((0, 0x1008ff18), spawn "chromium")                 -- XF86HomePage
					, ((0, 0x1008ff32), spawn "mpc single")               -- XF86AudioMedia
					, ((0, 0x1008ff1d), spawn "galculator")               -- XF86Calculator
					]

myXPConfig =
    defaultXPConfig {
        historyFilter       = deleteAllDuplicates ,
        showCompletionOnTab = True
}
