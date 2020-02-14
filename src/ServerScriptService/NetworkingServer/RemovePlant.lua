local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Object = require(ReplicatedStorage.Object)
local BlockScript = require(ReplicatedStorage.Object.Block)

local function RemovePlant(PlayerObject,Model)
	if not Model then return end
	
	local Block = BlockScript.BlockList[Model]

	if Block.OccupiedBy ~= "None" then
		local Server = _G.GetServer()
		local Player = Server.PlayerList[PlayerObject.userId]
		
		if Player:HasEmptySlot() then
			local Item = Block.OccupiedBy:CreateItem()
			local Success = Player:GiveItem(Item)
			if not Success then
				Item = nil
			end
		end
		
		Player.SaveData.Patch.Grid[Block.x][Block.z]:RemovePlant()
		
		Block:UpdateClient(Player,"OccupiedBy")
	end	
end

return RemovePlant