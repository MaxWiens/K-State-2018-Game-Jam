---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local KeyBlock = require 'objects.KeyBlock'
local Images = require'images.Images'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.LeftKeyBlock")
extends(_M, KeyBlock)

local _x
local _y
local _tileSet

function load(self, x, y)
	x = x or 0
	y = y or 0
	self._x = x
	self._y = y
	self._tileSet = Images.keyBlocks
end

function update(self, dt)
	if love.keyboard.isDown('left') then
		isActive = true
	else
		isActive = false
	end
end

function draw(self, xMod, yMod)
	if isActive then
		love.graphics.draw(self._tileSet.image, self._tileSet.quads[4], self._x + xMod, self._y + yMod)
	else
		love.graphics.draw(self._tileSet.image, self._tileSet.quads[1], self._x + xMod, self._y + yMod)
	end
end
