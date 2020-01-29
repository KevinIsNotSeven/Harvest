local Object = require(script.Parent)
local Block = require(script.Parent.Block)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetworkingEvent = ReplicatedStorage.Networking.NetworkingEvent

local Patch = {}
Patch.__index = Patch
setmetatable(Patch,{__index = Object})

function Patch.new(Player)
	local NewPatch = {}
	setmetatable(NewPatch,Patch)

	NewPatch.Grid = {}
	NewPatch.Player = Player
	
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
			local Dirt = Object.new("Block","Dirt",Vector3.new(x * NewPatch.BlockSize - NewPatch.BlockSize/2, 0, z * NewPatch.BlockSize - NewPatch.BlockSize/2) + Offset,NewPatch.Player)
		
			NewPatch.Grid[tostring(x)][tostring(z)] = Dirt
			NewPatch:UpdateClient(tostring(x),tostring(z))
			
			Dirt.Patch = NewPatch
			
			Dirt.x = tostring(x)
			Dirt:UpdateClient(x)
			
			Dirt.z = tostring(z)
			Dirt:UpdateClient(z)
			
			Block.BlockList[Dirt.Model] = Dirt
		end
	end
	
	return NewPatch
end

function Patch:UpdateClient(x,z)
	local Block = self.Grid[x][z]
	
	NetworkingEvent:FireClient(self.Player.PlayerObject,"UpdatePatch",x,z,Block)
end

return Patch

