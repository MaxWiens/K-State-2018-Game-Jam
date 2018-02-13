---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local GameMap = require'GameMap'
local TiledConverter = require'TiledConverter'
local TileGraphic = require'graphics.TileGraphic'
local teTestLevel = require'maps.teTestLevel'
local teTestLevelCollision = require'maps.teTestLevelCollision'
local Images = require'images.Images'
local Layer = require'Layer'
local TileCollision = require'TileCollision'
local Player = require'objects.Player'
local PlayerController = require'controllers.PlayerController'
local Stage = require'Stage'
local Grass = require'objects.Grass'
local GrassController = require'controllers.GrassController'
local Animation = require'graphics.Animation'
local Sun = require'objects.Sun'
local LeftKeyBlock = require'objects.LeftKeyBlock'
local RightKeyBlock = require'objects.RightKeyBlock'
local DownKeyBlock = require'objects.DownKeyBlock'
local extends = extends
local ipairs = ipairs 

--debug
local print = print 

module("maps.TestLevel")
extends(_M, GameMap) -- allowing the module to be used as a class

local layers
local rgb
local player
---
--
function load(self, midWorld, metaWorld)
	local maps = TiledConverter.getMaps(teTestLevel)
	local colMaps = TiledConverter.getMaps(teTestLevelCollision)
	self.rgb = {64, 126, 191}

	local reftable = {
		[4] = {base = Animation:new(Images.grass.block, 10, true)},
		[7] = {base = Animation:new(Images.grass.leftTri, 10, true)},
		[8] = {base = Animation:new(Images.grass.rightTri, 10, true)}
	}

	self.layers = {}
	local f1 = Layer:new()
	for y, row in ipairs(maps[2]) do
		for x, collumn in ipairs(row) do
			if reftable[maps[2][y][x]] then
				f1:add(GrassController:new(Grass:new(midWorld,(x*16)-16, (y*16)-16,  reftable[maps[2][y][x]] )))
			end
		end
	end
	f1:add(LeftKeyBlock:new(100,300))
	f1:add(DownKeyBlock:new(125,300))
	f1:add(RightKeyBlock:new(140,300))
	self.layers[4] = f1
	
	local m = Layer:new(TileGraphic:new(Images.ksgj, maps[1]))
	m:add(TileCollision:new(midWorld, colMaps[1], 16, 16, {ground = true}, {contactFloor = true}))
	m:add(TileCollision:new(midWorld, colMaps[2], 16, 16, {wall = true},{contactWall = true}))
	self.player = Player:new(midWorld, 120, 200)
	m:add(PlayerController:new(self.player))
	self.layers[3] = m

	local b1 = Layer:new(nil, 0, 0)
	b1:add(Sun:new(150, 0))
	self.layers[1] = b1
end

function createStage(self, camera)
	camera:track(self.player)
	return Stage:new(camera, self.layers, self.rgb)
end