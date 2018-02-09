---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- Tile set or atlas

local Object = require 'Object'
local love = love
local extends = extends

module("graphics.TileSet")
extends(_M, Object) -- allowing the module to be used as a class

local image -- Image which has the tiles
local quads -- Table of quads
local tileCount -- Number of tiles within the tile set
local tileWidth
local tileHeight

---
--
function load(self, imagePath, tileWidth, tileHeight)
	self.image = love.graphics.newImage(imagePath)
	self.quads = {}
	self.tileWidth = tileWidth
	self.tileHeight = tileHeight
	local imageWidth, imageHeight = self.image:getDimensions()
	local horizontalTiles = imageWidth/tileWidth
	local virticleTiles = imageHeight/tileHeight

	local tileCount = 0
	for y=0, imageHeight, tileHeight do
		for x=0,imageWidth, tileWidth do
			tileCount = tileCount + 1
			self.quads[tileCount] = love.graphics.newQuad( x, y, tileWidth, tileHeight, imageWidth, imageHeight)
		end
	end
	self.tileCount = tileCount
end