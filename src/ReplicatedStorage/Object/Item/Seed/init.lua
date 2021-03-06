local Object = require(script.Parent.Parent)
local Item = require(script.Parent)

local Seed = {}
Seed.__index = Seed
setmetatable(Seed,{__index = Item})

function Seed.new(SeedType,...)
	local Module = require(script[SeedType])
	local NewSeed = Module.new(...)
	
	NewSeed.SeedType = SeedType
	NewSeed.ItemName = SeedType
	
	return NewSeed
end

function Seed:Activate(PlayerObject,Model,Rotation)
	if not Model then return end
	
	local PlantType = self.SeedType
	local Block = require(Object.ReplicatedStorage.Object.Block).BlockList[Model]
	local Server = _G.GetServer()
	local Player = Server.PlayerList[PlayerObject.userId]
	local Slot = Player:FindItem(self)

	if Block.OccupiedBy == "None" and Block.Tilled and Player.SaveData.Hotbar[Slot]["2"] > 0 then
		Player.SaveData.Patch.Grid[Block.x][Block.z]:AddPlant(PlantType,Rotation)

		Block:UpdateClient(Player,"OccupiedBy")

		Player.SaveData.Hotbar[Slot]["2"] = Player.SaveData.Hotbar[Slot]["2"] - 1
		if Player.SaveData.Hotbar[Slot]["2"] == 0 then
			Player:RemoveItem(Slot)
		end

		Object.NetworkingEvent:FireClient(Player.PlayerObject,"UpdateInventory",Slot,Player.SaveData.Hotbar[Slot]["1"],Player.SaveData.Hotbar[Slot]["2"])
	end
end

function Seed:ActivateClient(Slot)
	local r = _G.root

	local block,_,rot = r.placing_mod.GetBlock()
	r.char.facing = CFrame.new(Vector3.new(),block.PrimaryPart.Position*Vector3.new(1,0,1) - r.char.pos*Vector3.new(1,0,1))

	Object.NetworkingEvent:FireServer("ActivateHotbar",Slot,block,rot)
end

return Seed