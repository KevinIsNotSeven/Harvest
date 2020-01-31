local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Object = require(script.Parent.Parent)
local Block = require(script.Parent)

local Dirt = {}
Dirt.__index = Dirt
setmetatable(Dirt,{__index = Block})

function Dirt.new()
	local NewDirt = {}
	setmetatable(NewDirt,Dirt)
	
	return NewDirt
end

return Dirt

