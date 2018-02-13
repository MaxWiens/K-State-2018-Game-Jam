---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local Images = require'images.Images'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.KeyBlock")
extends(_M, Object)

local _x
local _y
local _tileSet
local _quadIndex

function load(self, x, y)
	x = x or 0
	y = y or 0
	self._x = x
	self._y = y
	self._tileSet = Images.keyBlocks
end

function draw(self, xMod, yMod)
end
