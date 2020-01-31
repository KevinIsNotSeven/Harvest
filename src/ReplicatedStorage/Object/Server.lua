--Server
local Object = require(script.Parent)

local Server = {}
Server.Server = {}
Server.__index = Server
setmetatable(Server,{__index = Object})

function Server.new()
	local NewServer = {}
	setmetatable(NewServer,Server)
	
	Server.Server = NewServer

	NewServer.PlayerCount = 0
	NewServer.PlayerList = {}
	
	NewServer.CanTick = true
	NewServer.Version = "Testing"
	
	NewServer.Id = game.JobId
	
	return NewServer
end

function Server:AddPlayer(Player)
	self.PlayerList[Player.userId] = Player
	self.PlayerCount = self.PlayerCount + 1
end

function Server:RemovePlayer(Player)
	
	Player:UpdateData()
	
	self.PlayerCount = self.PlayerCount - 1
	self.PlayerList[Player.userId] = nil
end

function Server:Update()
	for _,Player in pairs(self.PlayerList) do
		Player:Update()
	end
end

return Server

