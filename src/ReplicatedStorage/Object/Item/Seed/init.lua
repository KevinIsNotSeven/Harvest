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
	
	NewSeed.Useable = true

	return NewSeed
end

function Seed:Activate(PlayerObject,Model,Rotation)
	if not Model then return end
	
	local PlantType = self.SeedType
	local Block = require(Object.ReplicatedStorage.Object.Block).BlockList[Model]
	
	if Block.OccupiedBy == "None" then
		local Server = _G.GetServer()
		local Player = Server.PlayerList[PlayerObject.userId]

		Player.SaveData.Patch.Grid[Block.x][Block.z]:AddPlant(PlantType,Rotation)

		Block:UpdateClient(Player,"OccupiedBy")
	end
end

function Seed:ActivateClient()
	local r = _G.root

	local block,_,rot = r.placing_mod.GetBlock()
	r.char.facing = CFrame.new(Vector3.new(),block.Part1.Position*Vector3.new(1,0,1) - r.char.pos*Vector3.new(1,0,1))

	Object.NetworkingEvent:FireServer("ActivateHotbar",r.char.SelectedSlot,block,rot)
end

return Seed