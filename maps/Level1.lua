---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local GameMap = require'GameMap'
local TiledConverter = require'TiledConverter'
local TileGraphic = require'graphics.TileGraphic'
local teLevel1 = require'maps.teLevel1'
local Images = require'images.Images'
local Layer = require'Layer'
local TileCollision = require'TileCollision'
local Stage = require'Stage'
local extends = extends

module("maps.Level1")
extends(_M, GameMap) -- allowing the module to be used as a class

local layers
local rgb
---
--
function load(self, midWorld, metaWorld)
	local maps = TiledConverter.getMaps(teLevel1)
	self.rgb = {4, 20, 73}

	self.layers = {}
	local f1 = Layer:new(TileGraphic:new(Images.ksgj, maps[2]))
	self.layers[1] = f1

	local m = Layer:new(TileGraphic:new(Images.ksgj, maps[1]))
	m:add(TileCollision:new(midWorld, maps[3], 16, 16))
	self.layers[3] = m
end

function createStage(self, camera)
	return Stage:new(camera, self.layers, self.rgb)
end