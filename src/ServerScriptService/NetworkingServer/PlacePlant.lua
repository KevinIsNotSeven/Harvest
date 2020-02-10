local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Object = require(ReplicatedStorage.Object)
local BlockScript = require(ReplicatedStorage.Object.Block)

local function PlacePlant(PlayerObject,Model,PlantType,Rotation)
	if not Model then return end
	
	local Block = BlockScript.BlockList[Model]
	
	if Block.OccupiedBy == "None" then
		local Server = _G.GetServer()
		local Player = Server.PlayerList[PlayerObject.userId]

		Player.SaveData.Patch.Grid[Block.x][Block.z]:AddPlant(PlantType,Rotation)

		Block:UpdateClient(Player,"OccupiedBy")
	end	
end

return PlacePlant