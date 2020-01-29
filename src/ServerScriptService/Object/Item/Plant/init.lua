local Object = require(script.Parent.Parent)
local Item = require(script.Parent)

local Plant = {}
Plant.__index = Plant
setmetatable(Plant,{__index = Item})

function Plant.new(PlantType,...)
	local Module = require(script[PlantType])
	local NewPlant = Module.new(...)
	
	NewPlant.PlantType = PlantType
	NewPlant.ItemName = PlantType
	
	return NewPlant
end

return Plant