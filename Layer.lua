---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- A layer is a single 2d slice of a stage

local Object = require 'Object'
local extends = extends
local pairs = pairs 

module("Layer")
extends(_M, Object)

local _objects	-- Table containing objects within the layer
local _xParalax	-- Number X-axis Paralax scroll rate
local _yParalax	-- Number Y-axis Paralax scroll rate
local _backGround -- Graphic 
local stage -- Stage which the layer belongs to
local xMod 
local yMod

---
-- Layer constructor
-- @param xPlx X-axis Paralax scroll rate
-- @param yPlx Y-axis Paralax scroll rate
function load(self, backGround, xPlx, yPlx)
	self._objects = {}
	self._xParalax = xPlx or 1
	self._yParalax = yPlx or 1
	backGround = backGround or {}
	backGround.layer = self
	self._backGround = backGround

end

---
-- Updates the objects within the layer
function update(self, dt)
	self.xMod = self.stage.xMod*self._xParalax
	self.yMod = self.stage.yMod*self._yParalax
	if self._backGround.update then	
		self._backGround:update()
	end
	for _,v in pairs(self._objects) do
		if v.update then
			v:update(dt)
		end
	end
end

---
-- Draws the objects within the layer
-- @param xMod The current X-position modifier
-- @param yMod The current Y-position modifier
function draw(self, xMod, yMod)
	if self._backGround.draw then
		self._backGround:draw(self.xMod, self.yMod)
	end
	for _,v in pairs(self._objects) do
		if v.draw then
			v:draw(self.xMod, self.yMod)
		end
	end
end

---
-- Add an object to the layer
-- @param object
function add(self, object)
	objectsLength = #self._objects
	insertionIndex = objectsLength+1
	for i=objectsLength, 1, -1 do
		if not self._objects[i] then
			insertionIndex = i
			break
		end
	end
	object.layerIndex = insertionIndex
	object.layer = self
	self._objects[insertionIndex] = object
end

---
-- Deletes a specific object from the layer and destroy's it's physics 
-- fixture if available
-- @param object The object to remove
function delete(self, object)
	local object = self._objects[object.layerIndex]

	if object.delete then
		object:delete()
	end

	if object._fixture then
		object._fixture:destroy()
	end
	self._objects[object.layerIndex] = nil

end

