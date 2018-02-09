---
-- @author Max Wiens-Evangelista
-- @copyright Max Wiens-Evangelista 2018
-- Functions which aid in dealing with .ini format files.
local ipairs = ipairs 
local pairs = pairs 
local util = require 'util'
local string = string
local tonumber = tonumber 
local tostring = tostring 

module('fileFormat.ini')

---
-- Converts a two-dimentional table into a string formatted in a .ini format.
-- The first dimention of the table is meant to have sections 
-- 
-- @param dataTable Table with sub-tables which act as sections within the ini
-- @return String which is in an ini format
function toIni (dataTable)
	local dataTable = dataTable or {}
	local str = ""
	if dataTable[1] ~= nil then
		local tbl = util.sortTableKeys(dataTable[1])
		for _,v in ipairs(tbl) do
			str = str..v[1]..'='..tostring(v[2])..'\n'
		end
	end
	for sectionName, section in pairs(dataTable) do
		if sectionName ~= 1 then
			str = str..'['..sectionName..']\n'
			local tbl = util.sortTableKeys(section)
			for _,v in ipairs(tbl) do
				str = str..v[1]..'='..tostring(v[2])..'\n'
			end
		end
	end
	return str
end


---
-- Parses a string which contains the contents of an ini file and returns
-- a two dimentional array with the first dimention being sections and the
-- second dimention being the settings and their values.
-- 
-- @param fileContents String containing the contents of an ini file
-- @return Table which contains the data stored within the ini fileContents
function parseIni (fileContents)
	local fileContents = fileContents or ''
	local t = {}
	t[1] = {}
	local currentSection = nil

	for line in string.gmatch(fileContents, "[^\n]+") do
		local sectionName = string.sub(line, 2, string.len(line)-1)
		if line == '['..sectionName..']' then
			currentSection = sectionName
			t[currentSection] = {}
		elseif string.sub(line, 1,1) ~= ';' then
			local parts = {}
			local i = 1
			for str in string.gmatch(line, "[^=]+") do
				parts[i] = str
				i = i + 1
			end
			local name = parts[1]
			local value = util.convertString(parts[2])

			if currentSection == nil then
				t[1][name] = value
			else
				t[currentSection][name] = value
			end
		end
	end

	return t
end

