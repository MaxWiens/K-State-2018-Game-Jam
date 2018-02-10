---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local GameMap = require'GameMap'
local love = love
local extends = extends
local ipairs = ipairs 

module("TiledConverter")

function getMaps(tiledExport)
	maps = {}
	for i,v in ipairs(tiledExport.layers) do
		maps[i] = {}
		for y=1, tiledExport.height do
			maps[i][y] = {}
			for x=1, tiledExport.width do
				maps[i][y][x] = v.data[(y*tiledExport.width-tiledExport.width)+x]
			end
		end
	end
	return maps
end