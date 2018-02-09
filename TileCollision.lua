---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- Base object prototype which objects are to be extended from

local Object = require'Object'
local extends = extends
local ipairs = ipairs 
local love = love

module('TileCollision')
extends(_M, Object)

TILE_COLLISION_REFERENCE = {
	[1] =  {0,0,	1,0,	1,1,	0,1}, -- square
	[2] =  {0,1,	1,0,	1,1}, -- 45 triangle up right
	[3] =  {0,0,	1,1,	0,1}, -- 45 triangle up left
	[4] =  {0,0,	1,0,	1,1}, -- 45 triangle down right
	[5] =  {0,0,	1,0,	0,1}, -- 45 triangle down left
	[6] =  {0,1,	1,.5,	1,1}, -- small half up right
	[7] =  {0,.5,	1,0,	1,1,	0,1}, -- big half up right
	[8] =  {0,0,	1,.5,	1,1,	0,1}, -- big half down right
	[9] =  {0,.5,	1,1,	0,1}, -- small half up right
	[10] = {0,0,	1,0,	1,.5}, -- small half down right
	[11] = {0,0,	1,0,	1,1,	0,.5}, -- big half down left
	[12] = {0,0,	1,0,	1,.5,	0,1}, --big half down right
	[13] = {0,0,	1,0,	0,.5}, -- small half down right
	[14] = {0,1,	.5,0,	1,0,	1,1}, -- big half left down
	[15] = {.5,1,	1,0,	1,1}, --small half left down
	[16] = {0,0,	.5,1,	0,1}, -- small right down
	[17] = {0,0,	.5,0,	1,1,	0,1}, -- big right down
	[18] = {0,0,	1,0,	1,1,	.5,1}, --bit left up
	[19] = {.5,0,	1,0,	1,1}, -- small left up
	[20] = {0,0,	.5,0,	0,1}, -- small right up
	[21] = {0,0,	1,0,	.5,1,	0,1}, -- big right up
	[22] = {0,.5,	1,.5,	1,1,	0,1}, -- half bottom
	[23] = {0,0,	.5,0,	.5,1,	0,1}, -- half left
	[24] = {.5,0,	1,0,	1,1,	.5,1}, -- half right
	[25] = {0,0,	1,0,	1,.5,	0,.5} -- half up
}

local layer
local collisionMap
local mapHeight
local mapWidth
local xScale
local yScale

local tileCount
local collidables

---
-- @param collisionMap 2 dymentional table whose values corrospond with a specific shape collsion
load = function (self, world, collisionMap, xScale, yScale, collisionType)
	self.xScale = xScale or 1
	self.yScale = yScale or 1
	local collisionType = collisionType or 'static'
	self.mapHeight = #collisionMap
	self.mapWidth = #collisionMap[1]
	self.tileCount = 0
	self.collidables = {}

	local scaledTileReference = {}
	for index,value in ipairs(TILE_COLLISION_REFERENCE) do
		scaledTileReference[index] = {}
		for i=1, #value do
			if i%2 == 1 then
				scaledTileReference[index][i] = value[i]*self.xScale
			else
				scaledTileReference[index][i] = value[i]*self.yScale
			end
		end
	end

	for y=1, self.mapHeight do
		for x=1, self.mapWidth do
			if collisionMap[y][x] ~= 0 then
				self.tileCount = self.tileCount + 1
				--find tile value at position
				self.collidables[self.tileCount] = {}
				self.collidables[self.tileCount][1] = love.physics.newBody( world, (x-1)*self.xScale, (y-1)*self.yScale, collisionType)
				self.collidables[self.tileCount][2] = love.physics.newChainShape(true, scaledTileReference[collisionMap[y][x]])
				self.collidables[self.tileCount][3] = love.physics.newFixture(self.collidables[self.tileCount][1], self.collidables[self.tileCount][2])
				self.collidables[self.tileCount][1]:setUserData(self)
				self.collidables[self.tileCount][3]:setUserData(self)
			end
		end
	end
end
--[[
function draw(self, xMod, yMod)
	for i,v in ipairs(self.collidables) do
		points = {}
		for i,v in ipairs({v[1]:getWorldPoints(v[2]:getPoints())}) do
			if i%2 == 1 then
				points[i] = v+xMod
			else
				points[i] = v+yMod
			end
		end

		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(255,0,255,255)
		love.graphics.polygon('fill', points)
		love.graphics.setColor(r,g,b,a)
	end
end
]]--