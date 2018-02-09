---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local Object = require'Object'
local love = love
local extends = extends
local type = type

--debug
local print = print 
local io = io

module("graphics.Background")
extends(_M, Object) -- allowing the module to be used as a class

local layer --layer which the TileGraphic is appart of
local flags
local image
local spriteBatch
local imageWidth
local imageHeight

---
--
--@param spriteBatch
function load(self, image, flags)
	local flags = flags or {
		xLoop = false,
		yLoop = false
	}
	if type(image) == 'string' then
		self.image = love.graphics.newImage(image)
	else 
		self.image = image
	end
	self.flags = flags
	self.spriteBatch = love.graphics.newSpriteBatch(self.image)
	self.imageWidth, self.imageHeight = self.image:getDimensions()
end

function update(self, dt)

	--self.spriteBatch:add()
	self.spriteBatch:clear()
	if self.flags.xLoop and self.flags.yLoop then
		self.spriteBatch:add(self.layer.xMod%self.imageWidth-self.imageWidth, self.layer.yMod%self.imageHeight-self.imageHeight)
		self.spriteBatch:add(self.layer.xMod%self.imageWidth-self.imageWidth, self.layer.yMod%self.imageHeight)
		self.spriteBatch:add(self.layer.xMod%self.imageWidth, self.layer.yMod%self.imageHeight-self.imageHeight)
		self.spriteBatch:add( self.layer.xMod%self.imageWidth, self.layer.yMod%self.imageHeight)
	elseif self.flags.xLoop then
		self.spriteBatch:add(self.layer.xMod%self.imageWidth-self.imageWidth, self.layer.yMod)
		self.spriteBatch:add( self.layer.xMod%self.imageWidth, self.layer.yMod)
	elseif self.flags.yLoop then
		self.spriteBatch:add(self.layer.xMod, self.layer.yMod%self.imageHeight-self.imageHeight)
		self.spriteBatch:add( self.layer.xMod, self.layer.yMod%self.imageHeight)
	else
		self.spriteBatch:add(self.layer.xMod, self.layer.yMod)
	end
	self.spriteBatch:flush()
end

function draw(self, xMod, yMod)
	
	love.graphics.draw(self.spriteBatch)
	--[[
	love.graphics.draw(self.image, xMod%self.imageWidth, yMod%self.imageHeight)
	love.graphics.draw(self.image, xMod%self.imageWidth-self.imageWidth, yMod%self.imageHeight)
	love.graphics.draw(self.image, xMod%self.imageWidth, yMod%self.imageHeight-self.imageHeight)
	love.graphics.draw(self.image, xMod%self.imageWidth-self.imageWidth, yMod%self.imageHeight-self.imageHeight)
	]]--
end
