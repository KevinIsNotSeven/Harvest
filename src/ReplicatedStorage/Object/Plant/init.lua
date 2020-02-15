local Object = require(script.Parent)
local PlantData = require(script.PlantData)

local Plant = {}
Plant.__index = Plant
setmetatable(Plant,{__index = Object})

function Plant.new(PlantType,BlockModel,Rotation,...)
	local Module = require(script[PlantType])
	local NewPlant = Module.new(...)
	
	NewPlant.PlantType = PlantType
	NewPlant.Stage = 1
	NewPlant.Ticks = 0
	NewPlant.Multiplier = 1

	NewPlant.Watered = false

	NewPlant.BlockModel = BlockModel
	NewPlant.Rotation = Rotation

	NewPlant.Model = Object.ReplicatedStorage.Plants[NewPlant.PlantType][NewPlant.PlantType .. tostring(NewPlant.Stage)]:Clone()
	NewPlant.Model:SetPrimaryPartCFrame(CFrame.new(NewPlant.BlockModel.PrimaryPart.Position) * CFrame.Angles(0,NewPlant.Rotation * math.pi/2,0))

	local BasePosition = NewPlant.Model.PrimaryPart.Position
	local BaseSize = NewPlant.Model.PrimaryPart.Size

	NewPlant.Model.Plant:SetPrimaryPartCFrame(CFrame.new(Vector3.new(BasePosition.X,BasePosition.Y + BaseSize.Y/2 + NewPlant.Model.Plant.Dirt.Size.Y/2,BasePosition.Z)))

	NewPlant.Model.Parent = game.Workspace.Plants

	return NewPlant
end

function Plant:CreateItem()
	return Object.new("Item","Plant",self.PlantType)
end

function Plant:Update()
	if self.Stage ~= PlantData[self.PlantType].MaxStage then
		self.Ticks = self.Ticks + (1 * self.Multiplier)

		if self.Ticks >= PlantData[self.PlantType].TicksPerStage then
			self:IncreaseStage()
		end
	end
end

function Plant:IncreaseStage()
	if self.Stage ~= PlantData[self.PlantType].MaxStage then
		self.Stage = self.Stage + 1
		self.Ticks = 0
					
		self.Model:Destroy()
		
		self.Model = Object.ReplicatedStorage.Plants[self.PlantType][self.PlantType .. tostring(self.Stage)]:Clone()
		self.Model:SetPrimaryPartCFrame(CFrame.new(self.BlockModel.PrimaryPart.Position) * CFrame.Angles(0,self.Rotation * math.pi/2,0))

		local BasePosition = self.Model.PrimaryPart.Position
		local BaseSize = self.Model.PrimaryPart.Size

		self.Model.Plant:SetPrimaryPartCFrame(CFrame.new(Vector3.new(BasePosition.X,BasePosition.Y + BaseSize.Y/2 + self.Model.Plant.Dirt.Size.Y/2,BasePosition.Z)))

		self.Model.Parent = game.Workspace.Plants
	end
end

function Plant:Destroy()
	self.Model:Destroy()
	self = nil
end

return Plant

