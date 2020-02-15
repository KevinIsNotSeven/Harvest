--Server
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Object = require(script.Parent)
local StarterData = require(script.StarterData)
local TestData = require(script.TestData)

local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
--local PlayerDataStore = DataStoreService:GetDataStore("PlayerData")

local Player = {}
Player.__index = Player
setmetatable(Player,{__index = Object})

function Player.new(PlayerObject)
	local NewPlayer = {}
	setmetatable(NewPlayer,Player)
	
	NewPlayer.userId = PlayerObject.userId
	NewPlayer.PlayerObject = PlayerObject
	
	NewPlayer:LoadData()

	Object.NetworkingEvent:FireClient(NewPlayer.PlayerObject,"LoadClient")

	return NewPlayer
end

function Player:GiveItem(Item,Amount)
	if not Amount then Amount = 1 end
	if not Item.Stackable and Amount > 1 then return false end

	if Item.Stackable then
		local Slot = self:CheckForItem(Item)
		
		if Slot then
			self.SaveData.Hotbar[Slot]["2"] = self.SaveData.Hotbar[Slot]["2"] + Amount
			Object.NetworkingEvent:FireClient(self.PlayerObject,"UpdateInventory",Slot,Item,Amount)
			Item = nil

			return true
		else
			if not self:HasEmptySlot() then return false end
	
			local Slot = self:GetEmptySlot()
			
			self.SaveData.Hotbar[Slot]["1"] = Item
			self.SaveData.Hotbar[Slot]["2"] = Amount
			Object.NetworkingEvent:FireClient(self.PlayerObject,"UpdateInventory",Slot,Item,Amount)

			return true
		end
	else
		if not self:HasEmptySlot() then return false end
	
		local Slot = self:GetEmptySlot()
		
		self.SaveData.Hotbar[Slot]["1"] = Item
		self.SaveData.Hotbar[Slot]["2"] = Amount
		Object.NetworkingEvent:FireClient(self.PlayerObject,"UpdateInventory",Slot,Item,Amount)

		return true
	end
	
	return false
end

function Player:RemoveItem(Slot)
	self.SaveData.Hotbar[Slot]["1"]:Destroy()
	self.SaveData.Hotbar[Slot]["1"] = "None"
	self.SaveData.Hotbar[Slot]["2"] = 0
end

function Player:GetItem(Slot)
	 if self.SaveData.Hotbar[tostring(Slot)]["1"] then
		return self.SaveData.Hotbar[tostring(Slot)]["1"]
	 end

	 return false
end

function Player:CheckForItem(Item1)
	for i = 1,5 do 
		local Item2 = self.SaveData.Hotbar[tostring(i)]["1"]

		if Item1.ItemType == Item2.ItemType and Item1.ItemName == Item2.ItemName then
			return tostring(i)
		end
	end

	return false
end

function Player:FindItem(Item)
	for i,Slot in pairs(self.SaveData.Hotbar) do
		if Slot["1"] == Item then
			return tostring(i)
		end
	end

	return false
end

function Player:HasEmptySlot()
	for _,Slot in pairs(self.SaveData.Hotbar) do
		if Slot["1"] == "None" then
			return true
		end
	end
	
	return false
end

function Player:GetEmptySlot()
	if not self:HasEmptySlot() then return end
	
	for i = 1,5 do
		if self.SaveData.Hotbar[tostring(i)]["1"] == "None" then
			return tostring(i)
		end
	end
end

function Player:PrintInventory()
	for i = 1,5 do
		if self.SaveData.Hotbar[tostring(i)]["1"] ~= "None" then
			print(tostring(i),self.SaveData.Hotbar[tostring(i)]["1"].DisplayName,self.SaveData.Hotbar[tostring(i)]["2"])
		else
			print(tostring(i),"None","0")
		end
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
	if not self.SaveData.Patch then return end
	
	for _,x in pairs(self.SaveData.Patch.Grid) do
		for _,Block in pairs(x) do
			if Block.OccupiedBy ~= "None" then
				Block.OccupiedBy:Update()
			end
		end
	end
end

return Player

