local Object = require(script.Parent)

local Block = {}
Block.BlockList = {}
Block.__index = Block
setmetatable(Block,{__index = Object})

function Block.new(BlockType,Position,...)
	local Module = require(script[BlockType])
	local NewBlock = Module.new(...)
	
	NewBlock.BlockType = BlockType
		
	NewBlock.State = {}
	NewBlock.OccupiedBy = "None"
	NewBlock.Patch = {}
	NewBlock.x = {}
	NewBlock.z = {}
	
	NewBlock.Model = game:GetService("ReplicatedStorage").Blocks[BlockType]:Clone()
	
	NewBlock.Model:SetPrimaryPartCFrame(CFrame.new(Position))
	NewBlock.Model.Parent = game.Workspace.Blocks
	
	return NewBlock
end

function Block:AddPlant(PlantType,Rotation)
	if self.OccupiedBy == "None" then
		local Plant = Object.new("Plant",PlantType,self,Rotation)
	
		self.OccupiedBy = Plant
	end
end

function Block:RemovePlant()
	if self.OccupiedBy ~= "None" then
		self.OccupiedBy:Destroy()
		
		self.OccupiedBy = "None"
	end
end

return Block

