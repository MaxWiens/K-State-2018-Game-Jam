---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local Object = require'Object'
local love = love
local extends = extends
local math = math

--debug
local print = print 
local io = io

module("graphics.TileGraphic")
extends(_M, Object) -- allowing the module to be used as a class

local layer --layer which the TileGraphic is appart of
local tileSet
local flags
local mapWidth 
local mapHeight
local map
local spriteBatch

---
--
--@param spriteBatch
function load(self, tileSet, map, flags)
	local flags = flags or {
		xLoop = false,
		yLoop = false
	}
	self.tileSet = tileSet
	self.map = map
	self.mapWidth = #map[1]
	self.mapHeight = #map
	self.spriteBatch = love.graphics.newSpriteBatch(tileSet.image)
	self.flags = flags
end

function update(self, dt)
	local xStartingTile = math.ceil(-self.layer.xMod/self.tileSet.tileWidth)
	local yStartingTile = math.ceil(-self.layer.yMod/self.tileSet.tileHeight)

	self.spriteBatch:clear()
	if self.flags.xLoop and self.flags.yLoop then
		for y = yStartingTile, self.mapHeight+yStartingTile do
			for x = xStartingTile, self.mapWidth+xStartingTile do
				relX = x%self.mapWidth+1
				relY = y%self.mapHeight+1
				if self.map[relY] and self.map[relY][relX] and self.map[relY][relX]~=0 then
					self.spriteBatch:add(self.tileSet.quads[self.map[relY][relX]], (x-1)*self.tileSet.tileWidth, (y-1)*self.tileSet.tileHeight)
				end
			end
		end
	elseif self.flags.xLoop then
		for y = yStartingTile, self.mapHeight+yStartingTile do
			for x = xStartingTile, self.mapWidth+xStartingTile do
				relX = x%self.mapWidth+1
				if self.map[y] and self.map[y][relX] and self.map[y][relX]~=0 then
					self.spriteBatch:add(self.tileSet.quads[self.map[y][relX]], (x-1)*self.tileSet.tileWidth, (y-1)*self.tileSet.tileHeight)
				end
			end
		end
	elseif self.flags.yLoop then
		for y = yStartingTile, self.mapHeight+yStartingTile do
			for x = xStartingTile, self.mapWidth+xStartingTile do
				relY = y%self.mapHeight+1
				if self.map[relY] and self.map[relY][x] and self.map[relY][x]~=0 then
					self.spriteBatch:add(self.tileSet.quads[self.map[relY][x]], (x-1)*self.tileSet.tileWidth, (y-1)*self.tileSet.tileHeight)
				end
			end
		end
	else
		for y = yStartingTile, self.mapHeight+yStartingTile do
			for x = xStartingTile, self.mapWidth+xStartingTile do
				if self.map[y] and self.map[y][x] and self.map[y][x]~=0 then
					self.spriteBatch:add(self.tileSet.quads[self.map[y][x]], (x-1)*self.tileSet.tileWidth, (y-1)*self.tileSet.tileHeight)
				end
			end
		end
	end
	self.spriteBatch:flush()
end

function draw(self, xMod, yMod)
	love.graphics.draw(self.spriteBatch, xMod, yMod)
end
