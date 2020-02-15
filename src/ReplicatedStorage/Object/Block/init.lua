local Object = require(script.Parent)

local Block = {}
Block.BlockList = {}
Block.__index = Block
setmetatable(Block,{__index = Object})

function Block.new(BlockType,Position,...)
	local Module = require(script[BlockType])
	local NewBlock = Module.new(...)
	
	NewBlock.BlockType = BlockType
		
	NewBlock.OccupiedBy = "None"
	NewBlock.Watered = false
	NewBlock.Tilled = false

	NewBlock.x = 0
	NewBlock.z = 0
	
	NewBlock.Model = Object.ReplicatedStorage.Blocks[BlockType]:Clone()
	NewBlock.Model:SetPrimaryPartCFrame(CFrame.new(Position))
	NewBlock.Model.Parent = game.Workspace.Blocks

	NewBlock.WaterModel = Instance.new("Model")
	local Water = Instance.new("Part")
	Water.Parent = NewBlock.WaterModel
	Water.Size = Vector3.new(2.5,.1,2.5)
	Water.Color = Color3.fromRGB(0, 100, 255)
	Water.Transparency = 1
	Water.TopSurface = "Smooth"
	NewBlock.WaterModel.PrimaryPart = Water
	NewBlock.WaterModel:SetPrimaryPartCFrame(CFrame.new(NewBlock.Model.PrimaryPart.Position))
	NewBlock.WaterModel.Name = "Water"
	NewBlock.WaterModel.Parent = NewBlock.Model
	
	return NewBlock
end

function Block:Till(Player)
	if self.Tilled then return end

	self.Tilled = true
	self.Model.PrimaryPart.Color = Color3.fromRGB(189,131,101)
	self:UpdateClient(Player,"Tilled")
end

function Block:Water(Player)
	if self.Watered or not self.Tilled then return end

	self.Watered = true
	self.WaterModel.PrimaryPart.Transparency = 0
	self:UpdateClient(Player,"Watered")

	if self.OccupiedBy ~= "None" then
		self.OccupiedBy.Watered = true
		self.OccupiedBy.Multiplier = 2
	end
end

function Block:AddPlant(PlantType,Rotation)
	if self.OccupiedBy == "None" then
		local Plant = Object.new("Plant",PlantType,self.Model,Rotation)
		
		if self.Watered then
			Plant.Watered = true
			Plant.Multiplier = 2
		end

		self.OccupiedBy = Plant
	end
end

function Block:RemovePlant()
	if self.OccupiedBy ~= "None" then
		self.OccupiedBy:Destroy()
		
		self.OccupiedBy = "None"
	end
end

function Block:UpdateClient(Player,Index)
	Object.NetworkingEvent:FireClient(Player.PlayerObject,"UpdateBlock",self.x,self.z,Index,self[Index])
end

return Block

