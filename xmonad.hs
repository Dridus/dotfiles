{-# OPTIONS_GHC -Wall -Werror -Wno-unused-imports #-}

import Data.Bits ((.|.))
import Data.Default (def)
import qualified Data.Map as M
import Data.Semigroup (Endo)
import Graphics.X11.ExtraTypes.XF86 ()
import System.Exit (ExitCode(ExitSuccess), exitWith)
import System.IO ()
import XMonad
  ( Choose, KeyMask, KeySym, Layout, LayoutMessages(ReleaseResources), Query, WindowSet, X, XConfig(XConfig), (<+>), (-->), (=?), borderWidth
  , broadcastMessage, className, composeAll, focusedBorderColor, focusFollowsMouse, handleEventHook, io, keys, kill, layoutHook, manageHook, mod1Mask, mod4Mask
  , normalBorderColor, restart, sendMessage, setLayout, shiftMask, spawn, startupHook, stringProperty, terminal, windows, withFocused, workspaces
  , xmonad
  )
import qualified XMonad
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.FloatNext (floatNextHook, toggleFloatAllNew, toggleFloatNext)
import XMonad.Hooks.ManageDocks (AvoidStruts, ToggleStruts(ToggleStruts), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers (doRectFloat)
import XMonad.Layout ((|||), Full(Full), IncMasterN(IncMasterN), ChangeLayout(NextLayout), Resize(Expand, Shrink))
import qualified XMonad.Layout.Decoration as D
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Maximize (Maximize, maximize, maximizeRestore)
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
import XMonad.Util.SpawnOnce (spawnOnce)

myTerminal :: String
myTerminal = "kitty"

gaps :: l a -> ModifiedLayout Spacing l a
gaps = spacingRaw True (Border 0 0 0 0) False (Border 4 4 4 4) True -- gaps (border / window spacing)

myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll . concat $
  -- [ [className =? "qutebrowser" --> doShift "Qutebrowser"]
  -- , [className =? "Spotify" --> doShift "Media"]
  -- , [className =? "Firefox" --> doShift "Firefox"]
  -- , [className =? "Chromium" --> doShift "Chrome"]
  [ [className =? c --> doRectFloat (StackSet.RationalRect 0.3 0.3 0.4 0.4) | c <- floatsClass]
  , [wmName =? "sxiv" -->  doRectFloat (StackSet.RationalRect 0.3 0.3 0.4 0.4)] 
  ]
  where
    wmName = stringProperty "WM_NAME"
    floatsClass = []

myNewManageHook :: Query (Endo WindowSet)
myNewManageHook = composeAll
  [ myManageHook
  , floatNextHook
  , manageHook desktopConfig
  -- , namedScratchpadManageHook scratchpads
  ]

promptConfig :: XPConfig
promptConfig = def
  { Prompt.font = "xft:Fira Code Retina:size=8"
  , Prompt.height = 40
  , Prompt.searchPredicate = fuzzyMatch
  -- , Prompt.sorter = fuzzySort
  }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { }) = M.fromList $
  [ ((mod1Mask              , XMonad.xK_Return), spawn myTerminal)
  , ((mod1Mask              , XMonad.xK_p     ), ShellPrompt.shellPrompt (XMonad.terminal conf) promptConfig)
  , ((mod1Mask              , XMonad.xK_c     ), xmonadPrompt promptConfig)
  , ((mod1Mask              , XMonad.xK_w     ), windowMultiPrompt promptConfig [(Goto, allWindows), (Goto, wsWindows)])
  , ((mod1Mask .|. shiftMask, XMonad.xK_w     ), windowMultiPrompt promptConfig [(Bring, allWindows), (Bring, wsWindows)])
  , ((mod1Mask              , XMonad.xK_Tab   ), nextWS)
  , ((mod1Mask .|. shiftMask, XMonad.xK_Tab   ), prevWS)
  , ((mod1Mask              , XMonad.xK_j     ), windows StackSet.focusDown) -- %! Move focus to the next window
  , ((mod1Mask              , XMonad.xK_k     ), windows StackSet.focusUp)
  , ((mod1Mask              , XMonad.xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
  , ((mod1Mask              , XMonad.xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area
  , ((mod1Mask              , XMonad.xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
  , ((mod1Mask .|. shiftMask, XMonad.xK_space ), setLayout $ layoutHook conf) -- %!  Reset the layouts on the current workspace to default
  , ((mod4Mask              , XMonad.xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
  , ((mod4Mask              , XMonad.xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area
  , ((mod4Mask              , XMonad.xK_t     ), withFocused $ windows . StackSet.sink) -- %! Push window back into tiling
  , ((mod4Mask              , XMonad.xK_h     ), sendMessage Shrink) -- %! Shrink the master area
  , ((mod4Mask              , XMonad.xK_l     ), sendMessage Expand) -- %! Expand the master area
  , ((mod4Mask              , XMonad.xK_m     ), windows StackSet.swapMaster) -- %! Swap the focused window and the master window
  , ((mod4Mask .|. shiftMask, XMonad.xK_j     ), windows StackSet.swapDown) -- %! Swap the focused window with the next window
  , ((mod4Mask .|. shiftMask, XMonad.xK_k     ), windows StackSet.swapUp) -- %! Swap the focused window with the previous window
   -- , ((mod4Mask              , XMonad.xK_m     ), windows StackSet.focusMaster  ) -- %! Move focus to the master window
  , ((mod4Mask .|. shiftMask, XMonad.xK_c     ), kill) -- %! Close the focused window
  , ((mod1Mask .|. shiftMask, XMonad.xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad.
  , ((mod1Mask .|. shiftMask, XMonad.xK_r     ), broadcastMessage ReleaseResources >> restart "xmonad" True) -- %! Restart xmonad
  , ((mod1Mask .|. shiftMask, XMonad.xK_x     ), spawn "p=$(pidof polybar) && kill $p; polybar main")
  , ((mod1Mask              , XMonad.xK_f     ), withFocused (sendMessage . maximizeRestore))
  , ((mod1Mask              , XMonad.xK_z     ), sendMessage MirrorShrink)
  , ((mod1Mask              , XMonad.xK_a     ), sendMessage MirrorExpand)
  , ((mod1Mask              , XMonad.xK_e     ), toggleFloatNext)
  , ((mod1Mask .|. shiftMask, XMonad.xK_e     ), toggleFloatAllNew)
  , ((mod1Mask              , XMonad.xK_b     ), sendMessage ToggleStruts) -- toggle fullscreen (really just lower status bar below everything)
  , ((mod1Mask              , XMonad.xK_g     ), toggleWindowSpacingEnabled)
  -- floating window keys
  -- , ((mod1Mask, XMonad.xK_equal), withFocused (keysMoveWindow (0, -30)))
  -- , ((mod1Mask, XMonad.xK_apostrophe), withFocused (keysMoveWindow (0, 30)))
  -- , ((mod1Mask, XMonad.xK_bracketright), withFocused (keysMoveWindow (30, 0)))
  -- , ((mod1Mask, XMonad.xK_bracketleft), withFocused (keysMoveWindow (-30, 0)))
  -- , ((controlMask .|. shiftMask, XMonad.xK_m), withFocused $ keysResizeWindow (0, -15) (0, 0))
  -- , ((controlMask .|. shiftMask, XMonad.xK_comma), withFocused $ keysResizeWindow (0, 15) (0, 0))
  ]
    ++ [ ((m .|. mod1Mask, k), windows $ f i) -- mod-[1..9], Switch to workspace N
       | (i, k) <- zip (workspaces conf) [XMonad.xK_1 .. XMonad.xK_9] -- mod-shift-[1..9], Move client to workspace N
       , (f, m) <- [(StackSet.greedyView, 0), (StackSet.shift, shiftMask)]
       ]

main :: IO ()
main = do
  xmonad . ewmh . docks $ desktopConfig
    { handleEventHook = handleEventHook desktopConfig
    , borderWidth        = 8
    , normalBorderColor  = "#606060"
    , focusedBorderColor = "#f0f0f0"
    , focusFollowsMouse  = False
    -- , modMask            = modMask
    , terminal           = myTerminal
    , workspaces         = ["Main", "Secondary"]
    , keys               = myKeys
    , startupHook        = spawnOnce "polybar main"
    , manageHook         = myNewManageHook <+> manageDocks
    , layoutHook         = avoidStruts
                         . gaps
                         . smartBorders
                         . maximize
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
      , D.decoHeight          = 24
      , D.fontName            = "xft:Fira Code Retina:size=7"
      }
