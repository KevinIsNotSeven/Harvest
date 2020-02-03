local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Server = require(ReplicatedStorage.Object.Server)
local Patch = require(ReplicatedStorage.Object.Patch)
local Block = require(ReplicatedStorage.Object.Block)

_G.GetServer = function()
	return Server.Server
end

_G.GetBlockList = function()
	return Block.BlockList
end

_G.PrintTable = function(Table)
	for i,v in pairs(Table) do
		print(i,v)
	end
end

return true