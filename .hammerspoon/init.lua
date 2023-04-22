-- https://github.com/asmagill/hs._asm.undocumented.spaces
local spaces = require "hs.spaces"
local screen = require "hs.screen"

function increase_window_height()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = f.h + 10
  win:setFrame(f)
end

function decrease_window_height()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = f.h - 10
  win:setFrame(f)
end

-- Increase window height
hs.hotkey.bind({'cmd'}, 'n', increase_window_height, nil, increase_window_height)

-- Decrease window height
hs.hotkey.bind({'cmd'}, 'p', decrease_window_height, nil, decrease_window_height)

-- Switch wezterm
-- hs.hotkey.bind({'alt','shift','ctrl'}, 'j', function ()
hs.hotkey.bind({'ctrl'}, '0', function ()
  local APP_NAME = 'WezTerm'
  function moveWindow(wezterm, space)
    -- move to main space
    local win = nil
    while win == nil do
      win = wezterm:mainWindow()
    end
    print("win = ", win)
    print("space = ", space)
    print("win:screen() = ", win:screen())
    local fullScreen = not win:isStandard()
    if fullScreen then
      hs.eventtap.keyStroke('cmd', 'return', 0, wezterm)
    end
    winFrame = win:frame()
    scrFrame = screen.mainScreen():frame()
    print(winFrame)
    print(scrFrame)
    winFrame.w = scrFrame.w
    winFrame.y = scrFrame.y
    winFrame.x = scrFrame.x
    print(winFrame)
    win:setFrame(winFrame, 0)
    print(win:frame())
    spaces.moveWindowToSpace(win, space)
    if fullScreen then
      hs.eventtap.keyStroke('cmd', 'return', 0, wezterm)
    end
    win:focus()
  end
  local wezterm = hs.application.get(APP_NAME)
  if wezterm ~= nil and wezterm:isFrontmost() then
    wezterm:hide()
  else
    local space = spaces.activeSpaceOnScreen()
    print("activeSpace() = ", space)
    if wezterm == nil and hs.application.launchOrFocus(APP_NAME) then
      local appWatcher = nil
      print('create app watcher')
      appWatcher = hs.application.watcher.new(function(name, event, app)
        print(name)
        print(event)
        if event == hs.application.watcher.launched and name == APP_NAME then
          app:hide()
          moveWindow(app, space)
          appWatcher:stop()
        end
      end)
      print('start watcher')
      appWatcher:start()
    end
    if wezterm ~= nil then
      moveWindow(wezterm, space)
    end
  end
end)

-- Hide alacritty if not in focus
-- hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
--   local alacritty = hs.application.get('Alacritty')
--   print(alacritty)
--   if alacritty ~= nil then
--      print('hiding alacritty')
--      alacritty:hide()
--   end
-- end)
