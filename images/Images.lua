---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local TileSet = require 'graphics.TileSet'
local love = love

module('images.Images')

ksgj = TileSet:new('images/ksgj.png', 16, 16)
cinder = {
	walk_right = TileSet:new('images/cinder/walk_right.png', 16, 16),
	walk_left = TileSet:new('images/cinder/walk_left.png', 16, 16),
	idle_right = TileSet:new('images/cinder/idle_right.png', 16, 16),
	idle_left = TileSet:new('images/cinder/idle_left.png', 16, 16),
	on_wall_left = TileSet:new('images/cinder/on_wall_left.png', 16, 16),
	on_wall_right = TileSet:new('images/cinder/on_wall_right.png', 16, 16)
}
grass = {
	block = TileSet:new('images/grass/block.png', 16, 16),
	rightTri = TileSet:new('images/grass/rightTri.png', 16, 16),
	leftTri = TileSet:new('images/grass/leftTri.png', 16, 16)
}
sun = {
	sun16 = love.graphics.newImage('images/sun/sun16.png'),
	sun20 = love.graphics.newImage('images/sun/sun20.png'),
	sun24 = love.graphics.newImage('images/sun/sun24.png'),
	sun30 = love.graphics.newImage('images/sun/sun30.png'),
	sun40 = love.graphics.newImage('images/sun/sun40.png')
} 

keyBlocks = TileSet:new('images/keyBlocks.png', 13, 13)
collision = TileSet:new('images/collision.png', 16, 16)
collision2 = TileSet:new('images/collision2.png', 16, 16)
background = love.graphics.newImage('images/background.png')