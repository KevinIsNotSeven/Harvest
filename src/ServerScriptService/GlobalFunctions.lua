local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Server = require(ReplicatedStorage.Object.Server)
local Patch = require(ReplicatedStorage.Object.Patch)
local Block = require(ReplicatedStorage.Object.Block)

_G.PrintTable = function(Table)
	for i,v in pairs(Table) do
		print(i,v)
	end
end

_G.GetServer = function()
	return Server.Server
end

_G.GetBlockList = function()
	return Block.BlockList
end

_G.GetTime = function(TimeType,IncludeSeconds,UTCorLocal)
	local Format = "*t"
	if UTCorLocal == "UTC" then
		Format = "!*t"
	end
	local Date = os.date(Format)
	local AMorPM = "AM"
	
	if TimeType == "12" and Date.hour > 12 then
		Date.hour = Date.hour - 12
		AMorPM = "PM"
	end

	local Time = tostring(Date.hour) .. ":" .. tostring(Date.min)

	if IncludeSeconds then
		Time = Time .. ":" .. tostring(Date.sec)
	end

	if TimeType == "12" then
		Time = Time .. " " .. AMorPM
	end

	return Time
end

_G.GetDate = function()
	local Date = os.date("*t")

	if Date.month < 10 then
		Date.month = "0" .. Date.month
	end

	return tostring(Date.month) .. "/" .. tostring(Date.day) .. "/" .. tostring(Date.year)
end

_G.GetLongDate = function()
	local Months = {"January","February","March","April","May","June","July","August","September","October","November","December"}
	local Date = os.date("*t")

	return Months[Date.month] .. " " .. tostring(Date.day) .. ", " .. tostring(Date.year)
end

return true