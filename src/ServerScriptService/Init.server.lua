local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(game.ServerScriptService.NetworkingServer)
local Object = require(ReplicatedStorage.Object)

local Server = Object.new("Server")

require(game.ServerScriptService.GlobalFunctions)

game.Players.PlayerAdded:Connect(function(PlayerObject)	
	local Player = Object.new("Player",PlayerObject)
	
	Server:AddPlayer(Player)
	
	wait(2)
	
	Player.SaveData.Patch = Object.new("Patch",Player)
	
	Player.SaveData.Hotbar["1"] = Object.new("Item","Tool","Hoe")
end)

game.Players.PlayerRemoving:Connect(function(PlayerObject)
	
	Server:RemovePlayer(Server.PlayerList[PlayerObject.userId])

end)

game:BindToClose(function()
	--wait(30)
end)

wait(1)

spawn(function()
	while wait(1) do
		if Server.CanTick then
			Server:Update()
		end
	end
end)


