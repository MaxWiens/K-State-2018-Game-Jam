---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local PhysicsObject = require'objects.PhysicsObject'
local Images = require'images.Images'
local Animation = require'graphics.Animation'
local SpotLight = require'objects.SpotLight'
local extends = extends
local math = math
local love = love

module('objects.Player')
extends(_M, PhysicsObject)

local layer
local controller
local _contactFlags
local _flags
local _body		-- love physics body
local _shape	-- love physics Shape
local _fixture	-- love physics fixture
local _quad
local _animations
local _flags

load = function (self, world, x, y)
	local x = x or 0
	local y = y or 0
	self._contactFlags = contactFlags or {contactPlayer = true}
	self._flags = flags or {
		isActive = true,
		walking = false,
		facing = 'right',
		contactWall = false,
		dashReady = true
	}
	self._body = love.physics.newBody(world, x, y, 'dynamic')
	self._body:setFixedRotation(true)
	self._body:setMass(100)
	self._body:setUserData(self)

	self._shape = love.physics.newRectangleShape(8,8)
	self._fixture = love.physics.newFixture(self._body, self._shape)
	self._fixture:setRestitution(.3)
	self._fixture:setUserData(self)
	
	self._animations = {
		walk_right = Animation:new(Images.cinder.walk_right, 10, true, 0, 1, 1, 8, 12),
		walk_left = Animation:new(Images.cinder.walk_left, 10, true, 0, 1, 1, 8, 12),
		idle_right = Animation:new(Images.cinder.idle_right, 10, true, 0, 1, 1, 8, 12),
		idle_left = Animation:new(Images.cinder.idle_left, 10, true, 0, 1, 1, 8, 12),
		on_wall_left = Animation:new(Images.cinder.on_wall_left, 10, true, 0, 1, 1, 5, 12),
		on_wall_right = Animation:new(Images.cinder.on_wall_right, 10, true, 0, 1, 1, 11, 12)
	}

	
end

function moveRight(self)
	x, y = self._body:getLinearVelocity()
	x = math.max(x, 100)
	self._body:setLinearVelocity(x, y)
end

function moveLeft(self)
	x, y = self._body:getLinearVelocity()
	x = math.min(x, -100)
	self._body:setLinearVelocity(x, y)
end

function jump(self)
	self._body:applyLinearImpulse(0, -40)
end

function drop(self)
	x, y = self._body:getLinearVelocity()
	y = math.max(y, 120)
	self._body:setLinearVelocity(x/1.1,y)
end

function cameraTrack(self)
	self.controller.layer.stage.camera:track(self)
end

function dash(self)
	x, y = self._body:getLinearVelocity()

	if self._flags.facing == 'left'	then
		x = math.min(x, -2000)
		self._body:applyLinearImpulse(-10, 0)
	else
		x = math.max(x, 2000)
		self._body:applyLinearImpulse(10, 0)
	end
end