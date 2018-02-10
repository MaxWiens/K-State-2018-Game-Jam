---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local oop = require 'oop' 
local Object = require 'Object'
local love = love
local extends = extends
-- end imports
--debug
local print = print 



module("graphics.Animation")
extends(_M, Object)

local _tileSet -- TileSet Object
local _frameRate -- number
local _msDelay
local _image
local _quads

local _finished -- if the animation is finished

local _frameCursor
local _msTimer

function load(self, tileSet, frameRate, loop, r, sx, sy, ox, oy, kx, ky)
	self._r = r or 0
	self._sx = sx or 1
	self._sy = sy or sx
	self._ox = ox or 0
	self._oy = oy or 0
	self._kx = kx or 0
	self._ky = ky or 0
	self._frameRate = frameRate
	self._msDelay = 1/frameRate
	self._tileSet = tileSet
	self._image = tileSet.image
	self._quads = tileSet.quads
	self._loop = loop

	self._finished = false

	self:reset()
end

function update(self, dt)
	if not self._finished then
		self._msTimer = self._msTimer + dt

		if self._msTimer >= self._msDelay  then
			self._msTimer = self._msTimer - self._msDelay
			self._frameCursor = self._frameCursor + 1

		end

		if self._frameCursor > self._tileSet.tileCount then
			if self._loop then
				self._frameCursor = 1
			else
				self._finished = true
				return
			end
		end
	end
end

function reset(self)
	self._frameCursor = 1
	self._msTimer = 0
	self._finished = false
end

function draw(self, xMod ,yMod)
	love.graphics.draw(self._image, self._quads[self._frameCursor], xMod, yMod, self._r, self._sx, self._xy, self._ox, self._oy, self._kx, self._ky)
end