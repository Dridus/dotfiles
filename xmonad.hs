{-# OPTIONS_GHC -Wall -Werror -Wno-unused-imports #-}

import Data.Bits ((.|.))
import Data.Default (def)
import qualified Data.Map as M
import Data.Semigroup (Endo)
import Graphics.X11.ExtraTypes.XF86 as XF86
import System.Exit (ExitCode(ExitSuccess), exitWith)
import System.IO ()
import XMonad
  ( Choose, KeyMask, KeySym, Layout, LayoutMessages(ReleaseResources), Query, WindowSet, X, XConfig(XConfig), (-->), (=?), borderWidth
  , broadcastMessage, className, composeAll, doShift, focusedBorderColor, focusFollowsMouse, handleEventHook, io, keys, kill, layoutHook, manageHook, modMask
  , mod1Mask, mod4Mask, normalBorderColor, restart, sendMessage, setLayout, shiftMask, spawn, startupHook, stringProperty, terminal, windows, withFocused, workspaces
  , xmonad
  )
import qualified XMonad
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.FloatNext (floatNextHook, toggleFloatAllNew, toggleFloatNext)
import XMonad.Hooks.ManageDocks (AvoidStruts, ToggleStruts(ToggleStruts), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, doRectFloat, isFullscreen)
import XMonad.Layout ((|||), Full(Full), IncMasterN(IncMasterN), ChangeLayout(NextLayout), Resize(Expand, Shrink))
import qualified XMonad.Layout.Decoration as D
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Maximize (Maximize, maximizeWithPadding, maximizeRestore)
import XMonad.Layout.NoBorders (SmartBorder, smartBorders)
import XMonad.Layout.ResizableTile (ResizableTall(ResizableTall), MirrorResize(MirrorExpand, MirrorExpand, MirrorShrink))
import XMonad.Layout.Simplest (Simplest(Simplest))
import XMonad.Layout.Spacing (Border(Border), Spacing, spacingRaw, toggleWindowSpacingEnabled)
import XMonad.Layout.TabBarDecoration (XPPosition(Top), tabBar, shrinkText, resizeVertical)
import XMonad.Prompt (XPConfig)
import qualified XMonad.Prompt as Prompt
import XMonad.Prompt.FuzzyMatch (fuzzyMatch, fuzzySort)
import qualified XMonad.Prompt.Shell as ShellPrompt
import XMonad.Prompt.Window (WindowPrompt(Goto, Bring), windowMultiPrompt, allWindows, wsWindows)
import XMonad.Prompt.XMonad (xmonadPrompt)
import qualified XMonad.StackSet as StackSet
import XMonad.Util.Cursor (setDefaultCursor, xC_left_ptr)
import XMonad.Util.SpawnOnce (spawnOnce, spawnOnOnce)

myTerminal :: String
myTerminal = "kitty"

alphaWS, betaWS, gammaWS, commWS, webWS, winWS :: String
alphaWS = "α"
betaWS  = "β"
gammaWS = "γ"
commWS  = "Comm"
webWS   = "Web"
winWS   = "Windows"

myWorkspaces :: [String]
myWorkspaces = [commWS, alphaWS, betaWS, webWS, winWS, gammaWS]

gaps :: l a -> ModifiedLayout Spacing l a
gaps = spacingRaw True (Border 0 0 0 0) False (Border 4 4 4 4) False -- gaps (border / window spacing)

myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll . concat $
  -- [ [className =? "qutebrowser" --> doShift "Qutebrowser"]
  -- , [className =? "Spotify" --> doShift "Media"]
  -- [ [className =? "Slack" --> doShift commWS]
  -- , [className =? "zoom" --> doShift commWS]
  [ [className =? c --> doRectFloat (StackSet.RationalRect 0.3 0.3 0.4 0.4) | c <- floatsClass]
  , [wmName =? "sxiv" -->  doRectFloat (StackSet.RationalRect 0.3 0.3 0.4 0.4)] 
  , [isFullscreen --> doFullFloat]
  ]
  where
    wmName = stringProperty "WM_NAME"
    floatsClass = []

myNewManageHook :: Query (Endo WindowSet)
myNewManageHook = composeAll
  [ myManageHook
  , floatNextHook
  , manageHook def
  -- , namedScratchpadManageHook scratchpads
  ]

-- runs whenever XMonad is started (or restarted)
myStartupHook :: X ()
myStartupHook = do
  spawnOnce "xcompmgr"
  spawnOnce "polybar main"
  spawnOnce "flameshot"
  spawnOnce "slack --silent"
  spawnOnce "QT_SCALE_FACTOR=2 zoom-us"
  setDefaultCursor xC_left_ptr

promptConfig :: XPConfig
promptConfig = def
  { Prompt.font = "xft:Fira Sans Medium:size=10"
  , Prompt.height = 40
  , Prompt.searchPredicate = fuzzyMatch
  -- , Prompt.sorter = fuzzySort
  }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { XMonad.modMask = modm }) = M.fromList
  $  [ ((modm                  , XMonad.xK_Return), spawn myTerminal)
     , ((modm                  , XMonad.xK_p     ), spawn "rofi -show run")
     , ((modm                  , XMonad.xK_s     ), spawn "rofi -show ssh")
     , ((modm                  , XMonad.xK_c     ), xmonadPrompt promptConfig)
     , ((modm                  , XMonad.xK_w     ), spawn "rofi -show window")
     , ((modm .|. shiftMask    , XMonad.xK_w     ), windowMultiPrompt promptConfig [(Bring, allWindows), (Bring, wsWindows)])
     , ((modm                  , XMonad.xK_Tab   ), windows StackSet.swapDown)
     , ((modm .|. shiftMask    , XMonad.xK_Tab   ), windows StackSet.swapUp)
     , ((modm                  , XMonad.xK_comma ), sendMessage (IncMasterN 1))
     , ((modm                  , XMonad.xK_period), sendMessage (IncMasterN (-1)))
     , ((modm                  , XMonad.xK_space ), sendMessage NextLayout)
     , ((modm .|. shiftMask    , XMonad.xK_space ), setLayout $ layoutHook conf)
     , ((modm                  , XMonad.xK_i     ), withFocused $ windows . StackSet.sink)
     , ((modm                  , XMonad.xK_minus ), sendMessage Shrink)
     , ((modm                  , XMonad.xK_equal ), sendMessage Expand)
     , ((modm                  , XMonad.xK_m     ), windows StackSet.swapMaster) -- %! Swap the focused window and the master window
     , ((modm .|. shiftMask    , XMonad.xK_c     ), kill) -- %! Close the focused window
     , ((modm .|. shiftMask    , XMonad.xK_q     ), broadcastMessage ReleaseResources >> restart "xmonad" True) -- %! Restart xmonad
     , ((modm .|. shiftMask    , XMonad.xK_x     ), spawn "p=$(pidof polybar) && kill $p; polybar main")
     , ((modm                  , XMonad.xK_f     ), withFocused (sendMessage . maximizeRestore) >> sendMessage ToggleStruts)
     , ((modm                  , XMonad.xK_z     ), sendMessage MirrorShrink)
     , ((modm                  , XMonad.xK_a     ), sendMessage MirrorExpand)
     , ((modm                  , XMonad.xK_u     ), toggleFloatNext)
     , ((modm .|. shiftMask    , XMonad.xK_u     ), toggleFloatAllNew)
     , ((modm                  , XMonad.xK_b     ), sendMessage ToggleStruts) -- toggle fullscreen (really just lower status bar below everything)
     , ((modm                  , XMonad.xK_g     ), toggleWindowSpacingEnabled)
     , ((mod1Mask              , XMonad.xK_Tab   ), windows StackSet.focusDown)
     , ((mod1Mask .|. shiftMask, XMonad.xK_Tab   ), windows StackSet.focusUp)

     , ((0, XF86.xF86XK_AudioMute),         spawn "pactl set-sink-mute 0 toggle")
     , ((0, XF86.xF86XK_AudioLowerVolume),  spawn "pactl set-sink-volume 0 -5%")
     , ((0, XF86.xF86XK_AudioRaiseVolume),  spawn "pactl set-sink-volume 0 +5%")
     , ((0, XF86.xF86XK_AudioMicMute),      spawn "pactl set-source-mute 1 toggle")
     , ((0, XF86.xF86XK_MonBrightnessDown), spawn "brightnessctl s 5%-")
     , ((0, XF86.xF86XK_MonBrightnessUp),   spawn "brightnessctl s 5%+")
     ]
  ++ [ ((modm .|. modifier, key), windows $ action ws)
     | (ws, key)          <- zip (workspaces conf) [XMonad.xK_1 .. XMonad.xK_9]
     , (action, modifier) <- [(StackSet.greedyView, 0), (StackSet.shift, shiftMask)]
     ]

main :: IO ()
main = do
  xmonad . ewmh . docks $ def
    { handleEventHook = handleEventHook def <> fullscreenEventHook
    , borderWidth        = 8
    , normalBorderColor  = "#606060"
    , focusedBorderColor = "#f0f0f0"
    , focusFollowsMouse  = False
    , modMask            = mod4Mask
    , terminal           = myTerminal
    , workspaces         = myWorkspaces
    , keys               = myKeys
    , startupHook        = myStartupHook
    , manageHook         = myNewManageHook <> manageDocks
    , layoutHook         = avoidStruts
                         . gaps
                         . smartBorders
                         . maximizeWithPadding 0
                         $ tabs ||| tiles
    }
  where
    tabs = tabBar shrinkText theme Top (resizeVertical (D.fi . D.decoHeight $ theme) Simplest)
    tiles = ResizableTall 1 (3 / 100) (1 / 2) []
    theme = def
      { D.activeColor         = "#f92672"
      , D.activeBorderColor   = "#f92672"
      , D.activeTextColor     = "#f8f8f2"
      , D.inactiveColor       = "#75715e"
      , D.inactiveBorderColor = "#75715e"
      , D.inactiveTextColor   = "#f8f8f2"
      , D.urgentColor         = "#fd971f"
      , D.urgentBorderColor   = "#fd971f"
      , D.urgentTextColor     = "#f8f8f2"
      , D.decoHeight          = 40
      , D.fontName            = "xft:Fira Sans Medium:size=11"
      }
