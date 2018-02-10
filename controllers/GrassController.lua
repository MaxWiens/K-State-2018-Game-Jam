module('controllers.GrassController')
extends(_M, Object)


local _grass 
local _animation

function load (self, grass)
	
	self._animation = 'idle_right'
	self._player = player
end

function update(self, dt)