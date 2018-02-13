---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local Animation = require'graphics.Animation'
local Images = require'images.Images'
local unpack = unpack 
local love = love
local extends = extends

-- debug
local print = print 

module("objects.Sun")
extends(_M, Object)

local _flags
local _images

local _TOTAL_TIME = 150
local _timer
local _rgb
local _startSkyRgb
local _endSkyRgb
local _x
local _y
local _endingY
local _startingY
local lum 

function load(self, x, y)
	x = x or 0
	y = y or 0
	self._x = x
	self._y = y

	self._images = {
		sun16 = Images.sun.sun16,
		sun20 = Images.sun.sun20,
		sun24 = Images.sun.sun24,
		sun30 = Images.sun.sun30,
		sun40 = Images.sun.sun40
	} 
	self._timer = 0
	self._flags = {sunSet = false}

	self._endingY = 144
	self._startingY = y
	self._startSkyRgb = {255, 126, 90}
	self._skyRgb = {self._startSkyRgb[1], self._startSkyRgb[2], self._startSkyRgb[3]}
	self._endSkyRgb = {4, 20, 73}
	self._rgb = {255, 255, 255}
	self.lum = 0
end

function update(self, dt)
	if not self._flags.sunSet then
		self._timer = self._timer + dt
		self._y = self._y + ((self._endingY-self._startingY)/_TOTAL_TIME)*dt
		self._skyRgb[1] = self._skyRgb[1] - ((self._startSkyRgb[1] - self._endSkyRgb[1])/_TOTAL_TIME)*dt
		self._skyRgb[2] = self._skyRgb[2] - ((self._startSkyRgb[2] - self._endSkyRgb[2])/_TOTAL_TIME)*dt
		self._skyRgb[3] = self._skyRgb[3] - ((self._startSkyRgb[3] - self._endSkyRgb[3])/_TOTAL_TIME)*dt
		love.graphics.setBackgroundColor(self._skyRgb)

		self._rgb[2] = self._rgb[2] - (200/(_TOTAL_TIME*.75))*dt
		self._rgb[3] = self._rgb[3] - (255/(_TOTAL_TIME/2))*dt
	end
	if self._timer >= _TOTAL_TIME and not self._flags.sunSet then
		self._flags.sunSet = true
		
	end

	if self._flags.sunSet then
		self.lum = self.lum + 200*dt
		if self.lum >= 255 then
			self.lum = 255
		end
	end
end

function draw(self, xMod, yMod)
	local sr, sg, sb = unpack(self._rgb)
	r, g, b, a =  love.graphics.getColor()
	love.graphics.setColor(sr, sg, sb, 128)
	love.graphics.draw(self._images.sun16, self._x+xMod, self._y+yMod, 0, 1, 1, 8, 8)
	love.graphics.setColor(sr, sg, sb, 64)
	love.graphics.draw(self._images.sun20, self._x+xMod, self._y+yMod, 0, 1, 1, 10, 10)
	love.graphics.setColor(sr, sg, sb, 32)
	love.graphics.draw(self._images.sun24, self._x+xMod, self._y+yMod, 0, 1, 1, 12, 12)
	love.graphics.setColor(sr, sg, sb, 16)
	love.graphics.draw(self._images.sun30, self._x+xMod, self._y+yMod, 0, 1, 1, 15, 15)
	love.graphics.setColor(sr, sg, sb, 8)
	love.graphics.draw(self._images.sun40, self._x+xMod, self._y+yMod, 0, 1, 1, 20, 20)
	love.graphics.setColor(r, g, b, a)
end
