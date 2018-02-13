---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local PhysicsObject = require 'objects.PhysicsObject'
local love = love
local extends = extends

-- debug
local print = print 

module("graphics.Camera")
extends(_M, PhysicsObject)

local _xResolution	-- number
local _yResolution 	-- number
local _body			-- love physics body
local _shape		-- love physics Shape
local _fixture		-- love physics fixture
local _trackedObject

---
-- 
-- @param body Physics body of the object
-- @param shape Physics shape of the object
-- @param density 
-- @param ... Colision masks
function load(self, xRes, yRes, world, x, y)
	local x = x or 0
	local y = y or 0
	self._xResolution = xRes
	self._yResolution = yRes
	self._body = love.physics.newBody(world, x, y, 'kinematic')
	self._shape = love.physics.newRectangleShape(xRes/2, yRes/2, xRes, yRes)
	self._fixture = love.physics.newFixture(self._body, self._shape)
	self._body:setMass(0)

	self._body:setUserData(self)
	self._fixture:setUserData(self)
	self._fixture:setSensor(true)
	self._fixture:setFilterData( 0, 0, -1) --
end

function update(self)
	if self._trackedObject then
		self._body:setX((self._trackedObject._body:getX()-self._xResolution/2))
		self._body:setY((self._trackedObject._body:getY()-self._yResolution/2))
	end
end

---
-- Gets the resolution of the camera
-- @return The X and Y resolution of the camera
function getResolution(self)
	return self._xResolution, self._yResolution
end

function track(self, physicsObject)
	self._trackedObject = physicsObject
end