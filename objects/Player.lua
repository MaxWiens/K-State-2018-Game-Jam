---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local PhysicsObject = require'objects.PhysicsObject'
local Images = require'images.Images'

module('objects.Player')
extends(PhysicsObject)

local _body		-- love physics body
local _shape	-- love physics Shape
local _fixture	-- love physics fixture
local _image

load = function (self, world, x, y)
	local x = x or 0
	local y = y or 0
	self._body = love.physics.newBody(world, x, y)
	self._shape = love.physics.newRectangleShape()
	self._fixture = love.physics.newFixture(self.body, self.fixture)
	self._image = Images.ksgj.quads[1]
end

function walkRight(self)
	x, y = self._body:getLinearVelocity()
	x = math.max(x, 10)
	self._body:setLinearVelocity(x, y)
end

function walkLeft(self)
	x, y = self._body:getLinearVelocity()
	x = math.min(x, -10)
	self._body:setLinearVelocity(x, y)
end

