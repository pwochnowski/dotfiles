import System.IO
import System.Exit
import XMonad
import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName


import XMonad.Actions.SpawnOn
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.WithAll
 
import XMonad.Layout.ResizableTile
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Tabbed
import XMonad.Layout.Decoration
import XMonad.Layout.TwoPane
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.SimpleDecoration (shrinkText)

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Core (X, withDisplay, io)
import Graphics.X11.Xinerama (getScreenInfo)
import Graphics.X11.Xlib.Types (Rectangle)
import XMonad.Util.Run (spawnPipe)

myTerminal = "konsole"
myModMask  = mod4Mask -- Win key is mod4Mask

-- Title Bar
-- myXmonadBar = "xmobar" ++ myXmobarrc
myXmobar = "xmobar /home/paulw/.xmobar/xmobarrc"
-- Color of current window title in xmobar.
-- xmobarTitleColor = "#FFB6B0"
-- Color of current workspace in xmobar.
-- xmobarCurrentWorkspaceColor = "#CEFFAC"
-- Dzen/Conky

myWorkspaces = ["1:term","2:lng","3:code", "4:web"] ++ map show [5..8] ++ ["9:exec"]

--myDFloat = doRectFloat (W.RationalRect (1/6) (1/6) (2/3) (2/3))
myManageHook = composeAll . concat $ 
  
  --[isDialog -e> myDFloat]
  [[isFullscreen --> (doF W.focusDown <+> doFullFloat)]
  , [className =? c --> doCenterFloat | c <- myCFloats]
  , [title =? t --> doCenterFloat | t <- myTFloats]
  , [resource =? r --> doCenterFloat | r <- myRFloats]
  , [(className =? i <||> title =? i <||> resource =? i) --> doIgnore | i <- myIgnores]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 0) | x <- my1Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 1) | x <- my2Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 2) | x <- my3Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 3) | x <- my4Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 4) | x <- my5Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 5) | x <- my6Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 6) | x <- my7Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 7) | x <- my8Shifts]
  , [(className =? x <||> title =? x <||> resource =? x) --> doShift (myWorkspaces !! 8) | x <- my9Shifts]
  ]
  where
--classes / titles / resources
  myCFloats = []
  myTFloats = []
  myRFloats = []
  myIgnores = []
  my1Shifts = []
  my2Shifts = ["chromium-browser"]
  my3Shifts = ["code-oss", "jetbrains-webstorm", "clion", "idea"]
  my4Shifts = ["Google-chrome", "Chromium"]
  my5Shifts = ["firefox"]
  my6Shifts = ["slack", "discord"]
  my7Shifts = []
  my8Shifts = []
  my9Shifts = []

myStartupHook :: X() 
myStartupHook = composeAll [
    withNthWorkspace W.view 8
    , killAll
    ,  spawnOn "9:exec" "konsole -e sh -c 'cd polez/docker/plp_dev_db; docker-compose up; zsh -i'"
    ,  spawnOn "9:exec" "konsole -e sh -c 'cd polez; echo Proxying; ./tools/server-proxy.sh; zsh -i'"
    ,  spawnOn "9:exec" "urxvt -e sh -c 'cd polez/powerlines; ./runserver.sh; zsh -i'"
    ,  spawnOn "9:exec" "urxvt -e sh -c 'cd polez/client; ./runclient.sh; zsh -i'"
    ,  spawnOn "2:lng" "dartiuma"
    ,  spawnOn "3:code" "code"
    ,  spawnOn "4:web" "google-chrome-stable"
    ,  spawnOn "5" "firefox"
    ,  spawnOn "6" "slack"
    ,  spawnOn "6" "discord"
  ]

------------------------------------------------------------------------
-- statusbar / logging
-- The log hook is what xmonad uses to tell us information about itself. 
-- Usually this hook is used in conjunction with other modules such as xmobar or dzen2. 
-- It tells us info about the status of the different workspaces, selected windows, etcetera. 
-- When configuring this hook, you usually pipe its result to the pipe you want to use to show the info.
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ def {
        ppCurrent = xmobarColor "#ceffac" ""
        , ppHidden = xmobarColor "#ffb7b0" "" 
        , ppUrgent = xmobarColor "#ceffac" "#573d26" 
        , ppSep = xmobarColor "#bb9584" "" " · "
        , ppWsSep = xmobarColor "#999999" "" " "
        , ppTitle = xmobarColor "#ffb7b0" "" . shorten 50
        , ppOutput = hPutStrLn h
}


------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ toggleLayouts full $ rt ||| mt ||| tab ||| tp ||| full
  where
  -- tiling profiles
  def = ResizableTall nmaster delta ratio []
  rt =  renamed [Replace "r" ] $ mySpacer $ def
  mt =  renamed [Replace "m" ] $ mySpacer $ Mirror rt
  tab = renamed [Replace "t" ] $ tabbed shrinkText myTabConfig
  tp = renamed [Replace "2" ] $ mySpacer $ TwoPane delta ratiotp
  full =  renamed [Replace "f"] $ noBorders $ fullscreenFull Full
  -- default #windows in master
  nmaster = 1
  -- proportion size of master
  ratio   = 7/10
  ratiotp = 5/10
  -- incrementation on resizing
  delta   = 2/100
  mySpacer = spacingRaw True (Border 1 1 1 1) True (Border 1 1 1 1) True


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))
  
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button2),
       (\w -> focus w >> mouseResizeWindow w))
  
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ] 





-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.0
myLauncher = "$(yeganesh -x -- -fn 'monospace-8' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"

myVolUp="amixer sset Master 10%+"
myVolDown="amixer sset Master 10%-"
myVolMute="amixer sset Master toggle"
myBrightUp="brightnessctl s +10%"
myBrightDown="brightnessctl s 10%-"

myKeys = [
  -- Move focus to next window 
    ("C-h", windows W.focusUp)
  -- Swap focused window with next window 
  , ("M-C-h", windows W.swapUp)
  -- Move focus to previous window 
  , ("C-l", windows W.focusDown)
  -- Swap focused window with previous window 
  , ("C-S-l", windows W.swapDown)
  -- Move focus to master window 
  , ("M-m", windows W.focusMaster)

  , ("M-j", sendMessage Shrink)
  , ("M-k", sendMessage Expand)
  , ("M-g", spawn "capture ")

  -- Quit Xmonad
  , ("M4-S-q", io (exitWith ExitSuccess))


  -- System Hotkeys
  , ("<Print>",  spawn "sleep 0.2; zsh -c \"scrot -s $HOME/Pictures/screenshots/%Y-%m-%d-%H:%M:%S.png; echo $HOME/Pictures/screenshots/*(om[1]) >/tmp/foo; xclip -t image/png -selection clipboard -i $HOME/Pictures/screenshots/*(om[1])\"") , ("S-<Print>",  spawn "zsh -c \"scrot $HOME/Pictures/screenshots/%Y-%m-%d-%H:%M:%S.png; xclip -t image/png -i $HOME/Pictures/screenshots/*(om[1])\"")
  -- VolDown
  , ("<XF86AudioLowerVolume>", spawn myVolDown)
  -- VolUp
  , ("<XF86AudioRaiseVolume>", spawn myVolUp)
  -- Mute 
  , ("<XF86AudioMute>", spawn myVolMute)
  -- brightness up
  , ("<XF86MonBrightnessUp>", spawn myBrightUp)
  -- brightness down
  , ("<XF86MonBrightnessDown>", spawn myBrightDown)

  -- Restart xmonad 
  , ("M-q", spawn "xmonad --recompile && xmonad --restart")

  , ("M-<Tab>", toggleWS)
  ] ++ 
  -- replace W.greedyView with view to avoid swapping windows with other screens
  [ 
    (otherModMasks ++ "M-" ++ [key], action tag) | (tag, key)  <- zip myWorkspaces "123456789", 
    (otherModMasks, action) <- [ 
      ("", windows . W.view), -- was W.greedyView
      ("S-", windows . W.shift)
    ]
  ]

------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
myNormalBorderColor  = "#7c7c7c"
myFocusedBorderColor = "#ffb6b0"

myBorderWidth = 1

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
-- Width of the window border in pixels.
myTabConfig = def { activeColor = "#3b3228"
                  , inactiveColor = "#3b3228"
                  , urgentColor = "#bb9584"
                  , activeBorderColor = "#3b3228"
                  , inactiveBorderColor = "#3b3228"
                  , urgentBorderColor = "#bb9584"
                  , activeTextColor = "#bb9584"
                  , inactiveTextColor = "#b8afad"
                  , urgentTextColor = "#3b3228"
                  , fontName = "xft:Liberation Mono:size=8"
                  }







------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    mouseBindings      = myMouseBindings
  } 

------------------------------------------------------------------------
--Run xmonad with all the defaults we set up.
--
main = do
  myBar <- spawnPipe myXmobar
  xmonad $ defaults {
      -- hooks, layouts
      layoutHook          = myLayout
      , logHook           = myLogHook myBar
      , manageHook        = manageSpawn <+> manageDocks <+> myManageHook
      -- , startupHook         = myStartupHook
      -- , handleEventHook   = docksEventHook
  } `additionalKeysP` myKeys


