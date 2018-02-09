---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- Metatables which can be assigned to tables to make them function
-- like prototype classes.


local util = require 'util'
local setmetatable = setmetatable 
local getmetatable = getmetatable 

module("oop")
---
-- Sets the extends function as a global function.
-- @param globalEnviornment the global enviornment table
initalize = function(globalEnviornment)
	globalEnviornment.extends = function (currentModule, prototype)
		if not metatableLookup[prototype._NAME] then
			metatableLookup[prototype._NAME] = {__index = prototype}
		end
		setmetatable(currentModule, metatableLookup[prototype._NAME])
	end
end

-- Metatable for prototype classes
PROTOTYPE_METATABLE = {
	__index = {
		---
		-- Creates a new object from the class which this function
		-- is called.
		--
		-- @param ... A number of arguments to be used in the constructor of the object
		-- @return New object 
		new = function (self, ...)
			local newObject = {}
			newObject = util.deepClone(self)
			setmetatable(newObject, getmetatable(self))
			newObject:load(...)
			return newObject
		end

	}
}

-- Metatable for active (new) objects
ACTIVE_METATABLE = {
	__index = {
		    

	}
}

metatableLookup = {}