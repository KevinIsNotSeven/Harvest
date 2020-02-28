--Server
local Object = require(script.Parent)

local Server = {}
Server.Server = {}
Server.__index = Server
setmetatable(Server,{__index = Object})

local clocktime = 0
local Seasons = {"Snowy","Love","Clover","Candy","Flower","Green","Hot","Beach","Chilly","Spooky","Feast","Festive"}
local Days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}

function Server.new()
	local NewServer = {}
	setmetatable(NewServer,Server)
	
	Server.Server = NewServer

	NewServer.PlayerCount = 0
	NewServer.PlayerList = {}
	
	NewServer.CanTick = true
	NewServer.TickRate = .1
	NewServer.Version = "Testing"
	NewServer.Id = game.JobId

	NewServer.Time = _G.GetTime("12",false,"Local")

	NewServer.Date = _G.GetDate()
	NewServer.LongDate = _G.GetLongDate()
	NewServer.WeekDay = Days[os.date("*t").wday]

	NewServer.Season = Seasons[NewServer.Month]

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

		self.Time = _G.GetTime("12",false,"Local")

		self.Date = _G.GetDate()
		self.LongDate = _G.GetLongDate()
		self.WeekDay = Days[os.date("*t").wday]

		self.Season = Seasons[self.Month]

		clocktime = clocktime + wait()/2
		if clocktime>24 then
			clocktime = clocktime - 24
		end
		local date = os.date("*t")
		clocktime = date.hour-1 + date.min/60 + date.sec/3600
		--clocktime = workspace.clocktime.Position.X/-50*24
		local monthtime = clocktime + date.day
		
		workspace.Lighting.sunmoon.CFrame = CFrame.Angles(clocktime/12*math.pi+math.pi,0,0)
		workspace.Lighting.stars.CFrame = CFrame.Angles(monthtime/12*math.pi,0,0)
		workspace.Lighting.sky.Color = _G.FindClosestKeypoint(workspace.LightingNormal.bruh.SkyColor.ParticleEmitter.Color.Keypoints,clocktime)
		workspace.Lighting.stars.Transparency = _G.FindClosestKeypoint(workspace.LightingNormal.bruh.StarTransparency.ParticleEmitter.Color.Keypoints,clocktime).r
		game.Lighting.Ambient = _G.FindClosestKeypoint(workspace.LightingNormal.bruh.Ambient.ParticleEmitter.Color.Keypoints,clocktime)
		--workspace.clocktime.SurfaceGui.TextLabel.Text = math.floor(clocktime)
	end
end

return Server

