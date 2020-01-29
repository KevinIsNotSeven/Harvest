local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkingEvent = ReplicatedStorage.Networking.NetworkingEvent
local NetworkingFunction = ReplicatedStorage.Networking.NetworkingFunction

NetworkingEvent.OnClientEvent:connect(function(Id,...)
	local Function = require(game.StarterPlayer.StarterPlayerScripts.Networking.NetworkingClient[Id])
	Function(...)
end)

NetworkingFunction.OnClientInvoke = function(Id,...)

end

return true