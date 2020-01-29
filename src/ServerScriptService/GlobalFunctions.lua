local Server = require(game.ServerScriptService.Object.Server)
local Patch = require(game.ServerScriptService.Object.Patch)
local Block = require(game.ServerScriptService.Object.Block)

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