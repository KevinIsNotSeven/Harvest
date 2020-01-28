local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkingEvent = ReplicatedStorage.Networking.NetworkingEvent
local NetworkingFunction = ReplicatedStorage.Networking.NetworkingFunction

NetworkingEvent.OnServerEvent:connect(function(Player,Id,...)
	local Function = require(game.ServerScriptService.NetworkingServer[Id])
	Function(Player,...)
end)

NetworkingFunction.OnServerInvoke = function(Player,Id,...)
	if Id == "GetPlayerData" then
		local Server = _G.GetServer()
		
		local Player = Server.PlayerList[Player.userId]
		
		return Player.SaveData
	elseif Id == "GetPlayerInventory" then
		local Server = _G.GetServer()
		
		local Player = Server.PlayerList[Player.userId]
		
		return Player.SaveData.Hotbar
	end
end

return true