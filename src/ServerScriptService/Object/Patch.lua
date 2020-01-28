local Object = require(script.Parent)
local Block = require(script.Parent.Block)

local Patch = {}
Patch.__index = Patch
setmetatable(Patch,{__index = Object})

function Patch.new()
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
			local Dirt = Object.new("Block","Dirt",Vector3.new(x * NewPatch.BlockSize - NewPatch.BlockSize/2, 0, z * NewPatch.BlockSize - NewPatch.BlockSize/2) + Offset)
		
			NewPatch.Grid[tostring(x)][tostring(z)] = Dirt
			
			Dirt.Patch = NewPatch
			Dirt.x = tostring(x)
			Dirt.z = tostring(z)
			
			Block.BlockList[Dirt.Model] = Dirt
		end
	end
	
	return NewPatch
end

function Patch:PrintStatus()
	for x,Object in pairs(self.Grid) do
		for z,Block in pairs(Object) do
			print(tostring(x),tostring(z),Block.BlockType)
		end
	end
end

return Patch

