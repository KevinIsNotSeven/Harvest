local Object = require(script.Parent)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetworkingEvent = ReplicatedStorage.Networking.NetworkingEvent

local Block = {}
Block.BlockList = {}
Block.__index = Block
setmetatable(Block,{__index = Object})

function Block.new(BlockType,Position,Player,...)
	local Module = require(script[BlockType])
	local NewBlock = Module.new(...)
	
	NewBlock.BlockType = BlockType
		
	NewBlock.OccupiedBy = "None"
	NewBlock.Patch = {}
	NewBlock.Player = Player
	NewBlock.x = {}
	NewBlock.z = {}
	
	NewBlock.Watered = false
	NewBlock.Tilled = false
	
	NewBlock.Model = ReplicatedStorage.Blocks[BlockType]:Clone()
	NewBlock.Model:SetPrimaryPartCFrame(CFrame.new(Position))
	NewBlock.Model.Parent = game.Workspace.Blocks
	
	return NewBlock
end

function Block:AddPlant(PlantType,Rotation)
	if self.OccupiedBy == "None" then
		local Plant = Object.new("Plant",PlantType,self.Model,Rotation)
	
		self.OccupiedBy = Plant
	end
end

function Block:RemovePlant()
	if self.OccupiedBy ~= "None" then
		self.OccupiedBy:Destroy()
		
		self.OccupiedBy = "None"
	end
end

function Block:UpdateClient(Index)
	NetworkingEvent:FireClient(self.Player.PlayerObject,"UpdateBlock",self.x,self.z,Index,self[Index])
end

return Block

