---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- A number of utility functions.

local pairs = pairs 
local type = type 
local math = math 
local tonumber = tonumber 
module("util")

---
-- Converts a string into the value the string represents in that
-- value's primative type.
-- ex.) if the string is '123' the number 123 would be returned.
-- 'false' would return false as a boolean.
-- 
-- @param str String which
-- @return The value of the string in 
function convertString(str)
	local str = str or ''
	local numVal = tonumber(str)
	local boolRef = {
		['true'] = true,
		['false'] = false
	}

	if numVal then
		return numVal
	elseif boolRef[str] ~= nil then
		return boolRef[str]
	elseif str == 'nil' then
		return nil
	else
		return str
	end
end


---
-- Creates a new table which has all the elements from table1
-- and table2. If there are elements which share the same name
-- in table1 as table2 they are overwritten
--
-- @param table1 One table to merge 
-- @param table2 Annother table to merge which can overwriteelements from table1
-- @return Merged table
function deepMerge(table1, table2)
	local table1 = table1 or {}
	local table2 = table2 or {}
	local newTable = _M.deepclone(table1)
	for key, value in pairs(table2) do
		if type(value) == 'table' then
			newTable[key] = {}
			newTable[key] = _M.deepMerge(table1[key], table2[key])
		else
			newTable[key] = value
		end
	end
	return newTable
end

---
-- Creates a new table which has all the values of a table passed
-- in to the function. This copy does not share any references with
-- the old table.
--
-- @param table Table to clone
-- @return Copied table
function deepClone(table)
	local newTable = {}
	for key, value in pairs(table) do
		if type(value) == 'table' and key ~= '_M' then
			newTable[key] = {}
			newTable[key] = _M.deepClone(value)
		else
			newTable[key] = value
		end
	end
	return newTable
end

---
-- Rounds a number to the nearest integer.
--
-- @param n Number to round
-- @return Rounded number
function round (n)
	if n < 0 then
		return math.ceil(n-.5)
	else 
		return math.floor(n+.5)
	end
end

---
-- Sorts a table by alphanumaric order of their keys.
-- The table that is returned 
-- @param t table
-- @return sorted table
-- 
function sortTableKeys (t)
	local t = t or {}
	local sortingTable = {}; local i = 1
	for k,v in pairs(t) do
		sortingTable[i] = {k, v}
		i = i + 1
	end
	local tableLength = i - 1
	-- Sorts table in alphabetical order
	for i = 1, tableLength - 1 do 
		local smallestIndex = i
		for j=i+1, tableLength do
			if sortingTable[j][1] < sortingTable[smallestIndex][1] then
				smallestIndex = j
			end
		end			
		-- Swaps table entries 
		local temp = sortingTable[i]
		sortingTable[i] = sortingTable[smallestIndex]
		sortingTable[smallestIndex] = temp
	end
	return sortingTable
end