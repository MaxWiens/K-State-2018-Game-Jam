---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- This SettingsManager loads, saves and manages game settings

local ini = require 'fileFormat.ini'
local util = require 'util'
local love = love 
local print = print 
local tostring = tostring 
local Object = require 'Object'
local extends = extends

module('Settings')
extends(_M, Object)

CONFIG_FILE_PATH = 'config.ini'

local _DEFAULT_SETTINGS = {
	audio = {
		master_volume=1.0
	},
	gameplay = {},
	video = {
		gamma_correction=false,
		window_width=1280,
		window_height=720,
		fullscreen=false,
		borderless=false,
		fullscreen_type='desktop',
		vsync=true,
		highdpi=false
	}
}

local _current = _DEFAULT_SETTINGS

---
-- Constructor which loads the config file if available or loads the default settings
-- and saves them to the config file if none are present.
-- @param filePath File path and name which the
function load (self)
	self._current = _DEFAULT_SETTINGS
	-- checks if the config file has been created
	if love.filesystem.exists(self.CONFIG_FILE_PATH) then
		local configFileContents = love.filesystem.read(self.CONFIG_FILE_PATH)
		self._current = ini.parseIni(configFileContents)
	else
		self:restoreDefaults()
		self:save()
	end
end

---
-- Saves the current game settings to the config file located in the standard LOVE
-- save directory.
function save (self)
	love.filesystem.write(self.CONFIG_FILE_PATH, ini.toIni(self._current))
end


---
-- Restores the default settings to the _current table. Note that this does not
-- save the settings.
function restoreDefaults (self)
	self._current = util.deepClone(_DEFAULT_SETTINGS)
end

---
-- Modifies a specific setting value.
-- @param section Section which the setting lies in
-- @param setting Name of the setting which to modify
-- @param value Value to assign to the specific setting
function modifySetting (self, section, setting, value)
	if(self._current[section] == nil or self._current[section][setting] == nil) then
		print('Attempt to modify nil setting: '..section..'/'..tostring(value))
		return
	end
	self._current[section][setting] = value
end

---
-- Returns a string of the current settings. This string is convenently in an ini format.
-- @returns current settings
function toString (self)
	return ini.toIni(self._current)
end

function current(self)
	return util.deepClone(_current)
end

function DEFAULT_SETTINGS()
	return util.deepClone(_DEFAULT_SETTINGS)
end

function updateSettings(self)
	self:save()
	love.window.setmode(
		_current.video.window_width, 
		_current.video.window_height,
		{fullscreen=_current.video.fullscreen,
		boarderless=_current.video.boarderless})
	love.audio.setVolume(_current.audio.master_volume)
	-- Display message that you may need to restart to see all changes take effect
end