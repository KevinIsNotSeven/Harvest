local Object = require(script.Parent.Parent.Parent)
local Tool = require(script.Parent)

local Hoe = {}
Hoe.__index = Hoe
setmetatable(Hoe,{__index = Tool})

function Hoe.new()
	local NewHoe = {}
	setmetatable(NewHoe,Hoe)
	
	return NewHoe
end

function Hoe:Activate(Block)
	
end

return Hoe

