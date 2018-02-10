---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local GameMap = require'GameMap'
local TiledConverter = require'TiledConverter'
local TileGraphic = require'graphics.TileGraphic'
local teLevel1 = require'maps.teLevel1'
local teLevel1Collision = require'maps.teLevel1Collision'
local Images = require'images.Images'
local Layer = require'Layer'
local TileCollision = require'TileCollision'
local Player = require'objects.Player'
local PlayerController = require'controllers.PlayerController'
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
	local colMaps = TiledConverter.getMaps(teLevel1Collision)
	self.rgb = {4, 20, 73}

	self.layers = {}
	local f1 = Layer:new(TileGraphic:new(Images.ksgj, maps[2]))
	self.layers[4] = f1

	local m = Layer:new(TileGraphic:new(Images.ksgj, maps[1]))
	m:add(TileCollision:new(midWorld, colMaps[1], 16, 16))
	m:add(PlayerController:new(Player:new(midWorld, 20, 200)))
	self.layers[3] = m
end

function createStage(self, camera)
	return Stage:new(camera, self.layers, self.rgb)
end