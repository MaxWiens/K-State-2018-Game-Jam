---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- Imports

love.graphics.setDefaultFilter( 'nearest', 'nearest', anisotropy )
local Settings = require'Settings'
local Level1 = require'maps.Level1'
local Camera = require'graphics.Camera'
local Stage = require'Stage'
-- End Imports


local _settings
local _currentStage
local _camera
local _worlds


function love.load()

	_settings = Settings:new()
	
	midWorld = love.physics.newWorld(0, 160)
	metaWorld = love.physics.newWorld(0,0)

	_camera = Camera:new(144, 256, metaWorld, 20, 200)

	level1 = Level1:new(midWorld, metaWorld)

	_currentStage = level1:createStage(_camera)

end

function love.update(dt)
	midWorld:update(dt)
	midWorld:setCallbacks( beginContact, endContact, preSolve, postSolve )
	metaWorld:update(dt)
	_currentStage:update(dt)

	_camera._body:setLinearVelocity(0,0)
	if love.keyboard.isDown('w') then
		_camera._body:setLinearVelocity(0,-100)
	end
	if love.keyboard.isDown('a') then
		_camera._body:setLinearVelocity(-100,0)
	end
	if love.keyboard.isDown('s') then
		_camera._body:setLinearVelocity(0,100)
	end
	if love.keyboard.isDown('d') then
		_camera._body:setLinearVelocity(100,0)
	end


end

function love.draw()
	love.graphics.scale( 5, 5 )

	_currentStage:draw()
end


function beginContact(a, b, coll)
	local acFlags = a:getUserData()._contactFlags or {}
	local bcFlags = b:getUserData()._contactFlags or {}
	for k,v in pairs(bcFlags) do
		a:getUserData()._flags[k] = v
	end
	for k,v in pairs(acFlags) do
		b:getUserData()._flags[k] = v
	end
end

function endContact(a, b, coll)
	local acFlags = a:getUserData()._contactFlags or {}
	local bcFlags = b:getUserData()._contactFlags or {}
	for k,v in pairs(bcFlags) do
		a:getUserData()._flags[k] = nil
	end
	for k,v in pairs(acFlags) do
		b:getUserData()._flags[k] = nil
	end
end

function preSolve(a, b, coll)
	-- body
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end


function love.keyboard.isPressed(key )
	-- body
end
