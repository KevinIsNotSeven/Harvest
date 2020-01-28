--Server
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Object = require(script.Parent)
local StarterData = require(script.StarterData)
local TestData = require(script.TestData)

local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
--local PlayerDataStore = DataStoreService:GetDataStore("PlayerData")

local NetworkingEvent = ReplicatedStorage.Networking.NetworkingEvent

local Player = {}
Player.__index = Player
setmetatable(Player,{__index = Object})

function Player.new(PlayerObject)
	local NewPlayer = {}
	setmetatable(NewPlayer,Player)
	
	NewPlayer.userId = PlayerObject.userId
	NewPlayer.PlayerObject = PlayerObject
	
	NewPlayer.Patch = {}
	
	NewPlayer:LoadData()
	
	NetworkingEvent:FireClient(NewPlayer.PlayerObject,"LoadClient")

	return NewPlayer
end

function Player:GetItem(Item)
	if not self:HasEmptySlot() then return false end
	
	local Slot = self:GetEmptySlot()
	
	self.SaveData.Hotbar[Slot] = Item
	
	return true
end

function Player:HasEmptySlot()
	for _,Item in pairs(self.SaveData.Hotbar) do
		if Item == "None" then
			return true
		end
	end
	
	return false
end

function Player:GetEmptySlot()
	if not self:HasEmptySlot() then return end
	
	for i = 1,5 do
		if self.SaveData.Hotbar[tostring(i)] == "None" then
			return tostring(i)
		end
	end
end

function Player:PrintInventory()
	for i = 1,5 do
		print(self.SaveData.Hotbar[tostring(i)].ItemName)
	end
end

function Player:LoadData()
	local Attempts = 0
	local Success = false
	
	local Server = _G.GetServer()
	
	if Server.Version == "Release" then
		repeat
			
			Attempts = Attempts + 1
			
			Success = pcall(function()
				
				local Data = PlayerDataStore:GetAsync(self.userId)
				
				if Data then
					self.SaveData = Data
				else				
					self.SaveData = StarterData()
				end
				
			end)
			
			wait(.1)
		
		until Success or Attempts == 10
		
		if not Success then
			print("Failed to load player data.")
			self.SaveData = StarterData()
			self.DoNotSave = true
		end
	elseif Server.Version == "Testing" then
		
		self.SaveData = TestData()
		self.DoNotSave = true
		
	end
end

function Player:UpdateData()
	local Attempts = 0
	local Success = false
	
	if self.SaveData and not self.DoNotSave then
		
		repeat
			
			Attempts = Attempts + 1
			
			Success = pcall(function()
				
				PlayerDataStore:SetAsync(self.userId,self.SaveData)
				
			end)
			
			wait(1)
			
		until Success or Attempts == 10
		
	end
	
end

function Player:Update()
	for _,Object in pairs(self.Patch.Grid) do
		for _,Block in pairs(Object) do
			if Block.OccupiedBy ~= "None" then
				Block.OccupiedBy:Update()
			end
		end
	end
end

return Player

