-- Required Object initalization not modify the following two lines
local oop = require 'oop'
oop.initalize(_G)

local ini = require 'fileFormat.ini'
local Settings = require 'Settings'
local settingsTable

if love.filesystem.exists(Settings.CONFIG_FILE_PATH) then
	settingsTable = ini.parseIni(love.filesystem.read(Settings.CONFIG_FILE_PATH))
else
	settingsTable = Settings.DEFAULT_SETTINGS()
	love.filesystem.write(Settings.CONFIG_FILE_PATH, ini.toIni(settingsTable))
end

function love.conf(t)

	t.console = true
	t.gammacorrect = settingsTable.video.gamma_correction

	t.window.title = "Cinder - K-State 2018 Game Jam"
	t.window.icon = nil
	t.window.width = settingsTable.video.window_width
	t.window.height = settingsTable.video.window_height
	t.window.borderless = settingsTable.video.borderless
	t.window.resizable = false
	t.window.minwidth = 1
	t.window.minheight = 1
	t.window.fullscreen = settingsTable.video.fullscreen
	t.window.fullscreentype = settingsTable.video.fullscreen_type
	t.window.vsync = settingsTable.video.vsync
	t.window.msaa = 0
	t.window.display = 1
	t.window.highdpi = settingsTable.video.highdpi

	t.window.vsync = settingsTable.video.vsync
end

