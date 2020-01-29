local Object = require(script.Parent)
local PlantData = require(script.PlantData)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Plant = {}
Plant.__index = Plant
setmetatable(Plant,{__index = Object})

function Plant.new(PlantType,Block,Rotation,Player,...)
	local Module = require(script[PlantType])
	local NewPlant = Module.new(...)
	
	NewPlant.PlantType = PlantType
	NewPlant.Player = Player
	NewPlant.Stage = 1
	NewPlant.Ticks = 0
	NewPlant.Block = Block
	NewPlant.Rotation = Rotation
	
	NewPlant.Model = ReplicatedStorage.Plants[PlantType][NewPlant.Stage]:Clone()
	
	NewPlant.Model:SetPrimaryPartCFrame(CFrame.new(NewPlant.Block.Model.Part1.Position) * CFrame.Angles(0,NewPlant.Rotation * math.pi/2,0))
	NewPlant.Model.Parent = game.Workspace.Plants
	
	return NewPlant
end

function Plant:CreateItem()
	return Object.new("Item","Plant",self.PlantType,self.Player)
end

function Plant:Update()
	if self.Stage ~= PlantData[self.PlantType].MaxStage then
		self.Ticks = self.Ticks + 1

		if self.Ticks == PlantData[self.PlantType].TicksPerStage then
			self:IncreaseStage()
		end
	end
end

function Plant:IncreaseStage()
	if self.Stage ~= PlantData[self.PlantType].MaxStage then
		self.Stage = self.Stage + 1
		self.Ticks = 0
					
		self.Model:Destroy()
		
		self.Model = ReplicatedStorage.Plants[self.PlantType][self.Stage]:Clone()
		self.Model:SetPrimaryPartCFrame(CFrame.new(self.Block.Model.Part1.Position) * CFrame.Angles(0,self.Rotation * math.pi/2,0))
		self.Model.Parent = game.Workspace.Plants
	end
end

function Plant:Destroy()
	self.Model:Destroy()
	self = nil
end

return Plant

