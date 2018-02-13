---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local GameMap = require'GameMap'
local TiledConverter = require'TiledConverter'
local TileGraphic = require'graphics.TileGraphic'
local teLevel1Collision = require'maps.teLevel1Collision'
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
local Background = require'graphics.Background'
local Goal = require 'objects.Goal'
local Loss = require 'objects.Loss'
local extends = extends
local ipairs = ipairs 

--debug
local print = print 

module("maps.Level1")
extends(_M, GameMap) -- allowing the module to be used as a class

local layers
local rgb
local player
---
--
function load(self, midWorld, metaWorld)
	local colMaps = TiledConverter.getMaps(teLevel1Collision)
	self.rgb = {64, 126, 191}

	local reftable = {
		[4] = {base = Animation:new(Images.grass.block, 10, true)},
		[7] = {base = Animation:new(Images.grass.leftTri, 10, true)},
		[8] = {base = Animation:new(Images.grass.rightTri, 10, true)}
	}
	self.layers = {}

	local f2 = Layer:new(nil, 0,0)
	goal = Goal:new(midWorld, 1152, 528)
	f2:add(goal)

	self.layers[5] = f2

	local f1 = Layer:new()
	f1:add(LeftKeyBlock:new(100,300))
	f1:add(DownKeyBlock:new(125,300))
	f1:add(RightKeyBlock:new(140,300))
	self.layers[4] = f1
	
	local m = Layer:new(TileGraphic:new(Images.collision, colMaps[1]))
	m:add(TileGraphic:new(Images.collision2, colMaps[2]))
	m:add(TileCollision:new(midWorld, colMaps[1], 16, 16, {ground = true}, {contactFloor = true}))
	m:add(TileCollision:new(midWorld, colMaps[2], 16, 16, {wall = true},{contactWall = true}))
	
	self.player = Player:new(midWorld, 192+6, 1488+4)
	m:add(PlayerController:new(self.player))
	self.layers[3] = m

	local b1 = Layer:new(nil, 0, 0)
	sun = Sun:new(180, 0)
	b1:add(sun)
	self.layers[1] = b1

	f2:add(Loss:new(sun, goal))

	local b2 = Layer:new(Background:new(Images.background, {xLoop = true}), 0.2, 0)
	self.layers[2] = b2
end

function createStage(self, camera)
	camera:track(self.player)
	s = Stage:new(camera, self.layers, self.rgb)
	s.player = player
	return s
end