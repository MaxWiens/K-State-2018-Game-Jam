---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- A number of debug functions.
local pairs = pairs 
local type = type 
local tostring = tostring 
local print = print 
local io = io
module("frameworkDebug")
---
-- Prints the contents of a table to the standard output. Indents
-- for sub-table contents.
--
-- @param table The table which should be printed
-- @param count The number of indents which should be present
function deepPrint (table, count)
	count = count or 0
	for key, value in pairs(table) do
		if key == '_M' or key == '_parent' then
			for i=1,count do
					io.write('=')
			end
			print(key,tostring(value))
		else
			if type(value) == 'table' then
				for i=1,count do
					io.write('=')
				end
				print(key,tostring(value))
				_M.deepPrint(value, count+1)
			else
				for i=1,count do
					io.write('=')
				end
				print(key,tostring(value))
			end
		end
	end
end