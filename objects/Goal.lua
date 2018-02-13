---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.Goal")
extends(_M, Object)

local _flags
local _body		-- love physics body
local _shape	-- love physics Shape
local _fixture	-- love physics fixture
local _rgba

function load(self, world, x, y)
	self._contactFlags = {goal = true}
	self._flags = {contactPlayer = false, won = false, playerDeleted = false}
	self._body = love.physics.newBody(world, x+8, y+8)
	self._shape = love.physics.newRectangleShape(32,16)
	self._fixture = love.physics.newFixture(self._body, self._shape, density)
	self._fixture:setSensor(true)
	
	self._body:setUserData(self)
	self._fixture:setUserData(self)
	self._rgba = {255, 255, 255, 0}
	self.lum = 0
end

function update(self, dt)
	if self._flags.contactPlayer and not self._flags.won then
		self._flags.won = true
	end
		
	if self._flags.won then
		self.lum = self.lum + 200*dt
		if self.lum >= 255 then
			self.lum = 255
		end
	end

end

function draw(self, xMod, yMod)
	r,g,b,a = love.graphics.getColor()
	if self._flags.contactPlayer then
		
		love.graphics.setColor(255,255,255, self.lum)
		love.graphics.polygon('fill', 0,0, 256,0, 256, 256, 0,256)
		love.graphics.setColor(r, g, b, a)
	end
	if self._flags.won then
		
		love.graphics.setColor(255,255,255, self.lum)
		love.graphics.polygon('fill', 0,0, 256,0, 256, 256, 0,256)
		if self.lum >= 255 then
			love.graphics.setColor(0,0,0)
			love.graphics.print('light', 256/2-16, 144/2-8)
		end
		love.graphics.setColor(r, g, b, a)
	end
end