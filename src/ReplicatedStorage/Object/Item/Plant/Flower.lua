local Object = require(script.Parent.Parent.Parent)
local Plant = require(script.Parent)

local Flower = {}
Flower.__index = Flower
setmetatable(Flower,{__index = Plant})

function Flower.new()
	local NewFlower = {}
	setmetatable(NewFlower,Flower)
	
	return NewFlower
end

return Flower

