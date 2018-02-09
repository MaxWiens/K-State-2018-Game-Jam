---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- Note that Layers are reperesented in a way where the smallest indexed layers
-- are in the back and the largest indexed layers are in the front (twards the screne).

local Object = require 'Object'
local extends = extends
local pairs = pairs 
local love = love

module("Stage")
extends(_M, Object)

local _layers 		-- Layers contained within the stage
local camera 		-- Camera object which the scene is viewed
local _layerCount 	-- The number of lwayers
local xMod
local yMod
local rgb

---
-- Stage constructor
-- @param cam Camera to display the stage
-- @param layers Number of layers or a table containing Layer objects
-- @param rgb table containing the rgb values of the stage background
function load(self, cam, layers, rgb)
	rgb = rgb or {0,0,0}
	local layers = layers or {}
	self.camera = cam
	self._layers = layers or {}
	for _,v in pairs(self._layers) do
		v.stage = self
	end
	self._layerCount = #layers
	love.graphics.setBackgroundColor(rgb)
end

---
function update(self, dt)
	self.xMod = -self.camera._body:getX()
	self.yMod = -self.camera._body:getY()
	for _, v in pairs(self._layers) do
		v:update(dt)
	end
end

---
-- Draws the objects within the layer
function draw(self)
	for _,v in pairs(self._layers) do
		v:draw(self.xMod, self.yMod)
	end
end



---
-- Add an object to the layer
function setLayer(self, layerIndex, layer)
	_layers[layerIndex] = layer
end

---
-- Deletes a specific object from the layer and destroy's it's physics 
-- fixture if available
-- @param object The object to remove
function delete(self, object)
	local object = self._objects[object.layerIndex]

	if object._fixture then
		object._fixture:destroy()
	end
	self._objects[object.layerIndex] = nil
end

