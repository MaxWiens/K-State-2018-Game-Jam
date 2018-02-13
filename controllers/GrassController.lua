
local Object = require'Object'
local extends = extends
local util = require'util'
local math = math

module('controllers.GrassController')
extends(_M, Object)


local layer
local _grass 
local _animation

function load (self, grass)
	self._contactFlags = contactFlags or {contactWall = false, contactFloor = true}
	self._grass = grass
	self._animation = 'base'
end

function update(self, dt)
	if self._grass._flags.contactPlayer then
		self._grass._burnPercent = self._grass._burnPercent + 4*dt
	end

	if self._grass._burnPercent >= 1 then
		self.layer:delete(self)
	end
end

function draw(self, xMod, yMod)
	self._grass._animations[self._animation]:draw(util.round(self._grass._body:getX())+xMod,math.ceil(self._grass._body:getY())+yMod)
end

function delete(self)
	self._grass._fixture:destroy()
	self._grass = nil
end