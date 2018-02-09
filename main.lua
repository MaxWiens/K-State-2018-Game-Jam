---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018

-- Imports
local Settings = require'Settings'
local Stage = require'Stage'
-- End Imports


local _settings
local _currentStage
local _worlds

function love.load()
	_settings = Settings:new()
	love.graphics.setDefaultFilter( 'nearest', 'nearest', anisotropy )
	--_currentStage = Stage:new()

end

function love.update(dt)
	-- world:update(dt)
	--_currentStage:update(dt)
end

function love.draw()
	love.graphics.scale( 5, 5 )

	--_currentStage:draw()
end
