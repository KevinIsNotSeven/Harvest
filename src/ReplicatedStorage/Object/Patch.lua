local Object = require(script.Parent)
local Block = require(script.Parent.Block)

local Patch = {}
Patch.__index = Patch
setmetatable(Patch,{__index = Object})

function Patch.new(Player)
	local NewPatch = {}
	setmetatable(NewPatch,Patch)

	NewPatch.Grid = {}
	
	setmetatable(NewPatch.Grid,{__index = function(_,x)
		NewPatch.Grid[x] = {}
		setmetatable(NewPatch.Grid[x],{__index = function(_,z)
			NewPatch.Grid[x][z] = {}
			return NewPatch.Grid[x][z]
		end})
		return NewPatch.Grid[x]
	end})
	
	NewPatch.BlockSize = 3
	NewPatch.Model = game.Workspace.Grid
	NewPatch.GridSize = NewPatch.Model.PrimaryPart.Size.X / NewPatch.BlockSize
	
	for x = 1,NewPatch.GridSize do
		for z = 1,NewPatch.GridSize do
			local Offset = NewPatch.Model.PrimaryPart.Position - Vector3.new(NewPatch.Model.PrimaryPart.Size.X/2,0,NewPatch.Model.PrimaryPart.Size.Z/2)
			local NewDirt = Object.new("Block","Dirt",Vector3.new(x * NewPatch.BlockSize - NewPatch.BlockSize/2, 0, z * NewPatch.BlockSize - NewPatch.BlockSize/2) + Offset)
		
			NewPatch.Grid[tostring(x)][tostring(z)] = NewDirt
			NewPatch:UpdateClient(Player,tostring(x),tostring(z))
			
			NewDirt.x = tostring(x)
			NewDirt:UpdateClient(Player,x)
			
			NewDirt.z = tostring(z)
			NewDirt:UpdateClient(Player,z)
			
			Block.BlockList[NewDirt.Model] = NewDirt
		end
	end
	
	return NewPatch
end

function Patch:UpdateClient(Player,x,z)
	local Block = self.Grid[x][z]
	
	Object.NetworkingEvent:FireClient(Player.PlayerObject,"UpdatePatch",x,z,Block)
end

return Patch

