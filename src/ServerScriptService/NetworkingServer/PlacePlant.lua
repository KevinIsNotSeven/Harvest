local BlockScript = require(game.ServerScriptService.Object.Block)

local function PlacePlant(PlayerObject,Model,PlantType,Rotation)
	if not Model then return end
	
	local Block = BlockScript.BlockList[Model]
	
	if Block.OccupiedBy == "None" then
		local Server = _G.GetServer()
		local Player = Server.PlayerList[PlayerObject.userId]

		Player.Patch.Grid[Block.x][Block.z]:AddPlant(PlantType,Rotation)
	end	
end

return PlacePlant