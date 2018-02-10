---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- import statements 
local Object = require 'Object'
local love = love
local extends = extends

-- debug
local print = print 

module("objects.Grass")
extends(_M, Object)

local _body		-- love physics body
local _shape	-- love physics Shape
local _fixture	-- love physics fixture

---
-- 
--
--
-- @param body Physics body of the object
-- @param shape Physics shape of the object
-- @param density 
-- @param ... Colision masks
function load(self, body, shape, density, ...)
	self._body = body
	self._shape = love.physics.newRectangleShape()
	self._fixture = love.physics.newFixture(self._body, self._shape, density)
	
	self._body:setUserData(self)
	self._fixture:setUserData(self)
end
