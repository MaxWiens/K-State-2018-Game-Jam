---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

local Object = require'Object'
local love = love
local extends = extends
local util = require'util'
local math = math
local pairs = pairs 
local ipairs = ipairs

--debug
local print = print 

module('controllers.PlayerController')
extends(_M, Object)


local _player 
local _animation

function load (self, player, flags)
	
	self._animation = 'idle_right'
	self._player = player
end

function update(self, dt)
	-- updates Animation
	self._player._animations[self._animation]:update(dt)
	
	--print(self._player._flags.contactWall, self._player._flags.contactFloor)
	vx, vy = self._player._body:getLinearVelocity()
	if vx > 30 then
		self._player._flags.facing = 'right'
	elseif vx< -30 then
		self._player._flags.facing = 'left'
	end

	if self._player._flags.contactWall then
		--self:turnAround()
		self._animation = 'on_wall_'..self._player._flags.facing
	elseif self._player._flags.walking then
		self._animation = 'walk_'..self._player._flags.facing
	else
		self._animation = 'idle_'..self._player._flags.facing
	end

	if self._player._flags.contactWall and not self._player._flags.contactFloor then
		if self._player._flags.facing == 'left' then
			self._player._body:setLinearVelocity(-100,0)
		else
			self._player._body:setLinearVelocity(100,0)
		end

		
		if self._player._flags.facing == 'right' and love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
			self._player._body:setLinearVelocity(-100,-100)
			self._player._flags.facing = 'left'
		elseif self._player._flags.facing == 'left' and love.keyboard.isDown('right') and not love.keyboard.isDown('left') then
			self._player._body:setLinearVelocity(100,-100)
			self._player._flags.facing = 'right'
		else
			self._player._flags.walking = false
		end
	else
		if love.keyboard.isDown('left') then
			self._player:moveLeft()
			self._player._flags.walking = true
		elseif love.keyboard.isDown('right') then
			self._player:moveRight()
			self._player._flags.walking = true
		else
			self._player._flags.walking = false
		end
	end

end

function draw(self, xMod, yMod)

	--love.graphics.draw(self._player._image, self._player._quad, self._player._body:getX()+xMod, self._player._body:getY()+yMod, 0,  1,1, 8, 12)
	self._player._animations[self._animation]:draw(util.round(self._player._body:getX())+xMod,math.ceil(self._player._body:getY())+yMod)
	--[[
	points = {}
	for i,v in ipairs({self._player._body:getWorldPoints(self._player._shape:getPoints())}) do
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
	]]--
end

function turnAround(self)
	if self._player._flags.facing == 'right' then
		self._player._flags.facing = 'left'
	else
		self._player._flags.facing = 'right'
	end
end