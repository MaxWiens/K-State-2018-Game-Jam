---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local Object = require'Object'


module('controllers.PlayerController')
extends(Object)

local _flags
local _player 

function load (self, player, flags)
	self._flags = flags or {
		isActive = true
	}
	self._player = player
end

function draw(self, xMod, yMod)
	love.graphics.draw()
end