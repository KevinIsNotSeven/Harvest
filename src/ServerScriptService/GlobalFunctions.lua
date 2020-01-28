local Server = require(game.ServerScriptService.Object.Server)
local Patch = require(game.ServerScriptService.Object.Patch)

_G.GetServer = function()
	return Server.Server
end

_G.PrintTable = function(Table)
	for i,v in pairs(Table) do
		print(i,v)
	end
end

return true