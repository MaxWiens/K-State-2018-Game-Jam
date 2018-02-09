---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- This is a GenaricObject class to demonstrate how
-- a class would be formatted with this framework 

-- import statements 
local oop = require 'oop' 
local Object = require 'Object'
local extends = extends

--start of prototype class
module("GenaricObject")
extends(_M, Object) -- allowing the module to be used as a class

local var1 = 0   -- variables act as static variables
local var2 = 111 -- local variables act as static aswell but will be 'hidden' if the module is looped through thus are more protected

---
-- A global load function is required for an class and act as a constructor.
--
-- @param var1 The value assigned to _var1
-- @param var2 the value assigned to _var2
-- @return New object 
function load(self, v1, v2)
	self.var1 = v1 or var1  -- 	it is importat to store the initialized variables in self 
	self.var2 = v2 or var2  -- unless you want to update the static variable. 
end
