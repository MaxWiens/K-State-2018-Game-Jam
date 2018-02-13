---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local Animation = require'graphics.Animation'
local Images = require'images.Images'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.Grass")
extends(_M, Object)

local _controller
local _flags
local _body		-- love physics body
local _shape	-- love physics Shape
local _fixture	-- love physics fixture
local _animations

local _burnPercent 

function load(self, world, x, y, animations, flags)
	animations = animations or {base = Animation:new(Images.grass.block, 10, true)}
	self._flags = flags or {
		contactPlayer = false
	}
	self._body = love.physics.newBody(world, x, y)
	self._shape = love.physics.newRectangleShape(8,8, 16, 16)
	self._fixture = love.physics.newFixture(self._body, self._shape)
	self._fixture:setSensor(true)
	self._body:setUserData(self)
	self._fixture:setUserData(self)

	self._animations = animations
	self._burnPercent = 0
end

