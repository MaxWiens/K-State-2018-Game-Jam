---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- Base object prototype which objects are to be extended from

local oop = require 'oop'
local setmetatable = setmetatable 
local string = string
local tostring = tostring 

module('Object')
setmetatable(_M, oop.PROTOTYPE_METATABLE)

---
-- This function is called if there is no load function in the object prototype
-- to use as a constructor and throws an error.
load = function ()
	error("No load function in object prototype")
end

toString = function (self)
	local tableRef = tostring(self)

	return self:getType()..string.sub(tableRef, 6, string.len(tableRef))
end

getType = function (self)
	return self._NAME
end