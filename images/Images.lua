---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local TileSet = require 'graphics.TileSet'

module('images.Images')

ksgj = TileSet:new('images/ksgj.png', 16, 16)
cinder = {
	walk_right = TileSet:new('images/cinder/walk_right.png', 16, 16),
	walk_left = TileSet:new('images/cinder/walk_left.png', 16, 16),
	idle = TileSet:new('images/cinder/idle.png', 16, 16)
}