---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local Object = require'Object'
local love = love
local extends = extends

--debug
local print = print 

module('controllers.PlayerController')
extends(_M, Object)

local _flags
local _player 
local _animation

function load (self, player, flags)
	self._flags = flags or {
		isActive = true,
		walking = false,
		facing = 'right'
	}
	self._animation = 'none'
	self._player = player
end

function update(self, dt)
	self._player._animations[self._animation]:update(dt)
	-- updates Animation
	if self._flags.walking then
		self._animation = 'walk_'..self._flags.facing
	else
		self._animation = 'none'
	end

	if love.keyboard.isDown('left') then
		self._player:moveLeft()
		self._flags.walking = true
		self._flags.facing = 'left'
	elseif love.keyboard.isDown('right') then
		self._player:moveRight()
		self._flags.walking = true
		self._flags.facing = 'right'
	else
		self._flags.walking = false
	end

end

function draw(self, xMod, yMod)
	--love.graphics.draw(self._player._image, self._player._quad, self._player._body:getX()+xMod, self._player._body:getY()+yMod, 0,  1,1, 8, 12)
	self._player._animations[self._animation]:draw(self._player._body:getX()+xMod,self._player._body:getY()+yMod)
end