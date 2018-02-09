---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local GameMap = require'GameMap'
local love = love
local extends = extends

module("maps.ExampleMap")
extends(_M, GameMap) -- allowing the module to be used as a class

local layers
local rgb
---
--
function load(self)
	self.rgb = {255, 255, 255}

	self.layers = {}
	local l1 = Layers:new(background, xPlx, yPlx)
	l1:add(object)
	l1:add(object)
	l1:add(object)
	l1:add(object)
	self.layers[1] = l1
	local l2 = Layers:new(background, xPlx, yPlx)
	l2:add(object)
	l2:add(object)
	l2:add(object)
	l2:add(object)
	self.layers[2] = l2
	l3 = Layers:new(background, xPlx, yPlx)
	l3:add(object)
	self.layers[3] = l3
	l4 = Layers:new(background, xPlx, yPlx)
	l4:add(object)
	l4:add(object)
	self.layers[4] = l4
end

function createStage(self, camera)
	return Stage:new(camera, self.layers, self.rgb)
end