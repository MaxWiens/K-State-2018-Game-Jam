---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.Loss")
extends(_M, Object)

function load(self, sun, goal)
	self.goal = goal
	self.sun = sun
	self.lum = 0
end

function update(self, dt)
	if self.sun._flags.sunSet then
		self.lum = self.lum + 200*dt
		if self.lum >= 255 then
			self.lum = 255
		end
	end
end

function draw(self)
	r,g,b,a = love.graphics.getColor()
	if self.sun._flags.sunSet and self.goal._flags.won == false then
		
		love.graphics.setColor(0,0,0, self.lum)
		love.graphics.polygon('fill', 0,0, 256,0, 256, 256, 0,256)
		if self.lum >= 255 then
			love.graphics.setColor(255,255,255)
			love.graphics.print('dark', 256/2-16, 144/2-8)
		end
		love.graphics.setColor(r, g, b, a)
	end
end
