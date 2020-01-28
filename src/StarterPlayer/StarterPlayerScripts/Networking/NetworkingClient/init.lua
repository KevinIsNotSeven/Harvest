local NetworkingEvent = game.ReplicatedStorage.Networking.NetworkingEvent
local NetworkingFunction = game.ReplicatedStorage.Networking.NetworkingFunction

NetworkingEvent.OnClientEvent:connect(function(Id,...)
	local Function = require(game.StarterPlayer.StarterPlayerScripts.Networking.NetworkingClient[Id])
	Function(...)
end)

NetworkingFunction.OnClientInvoke = function(Id,...)

end

return true