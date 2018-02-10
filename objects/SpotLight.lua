---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local Images = require 'images.Images'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.SpotLight")
extends(_M, Object)

local _tileSet

function load(self)
	self._tileSet = Images.spotLight
end

function draw(self, xMod, yMod)
	local r,g,b,a = love.graphics.getColor()
	love.graphics.setColor(255, 130, 0, 10)
	love.graphics.draw(self._tileSet.image, xMod, yMod, 0, 1, 1, 32, 32)
	love.graphics.setColor(r,g,b,a)
end
