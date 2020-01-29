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

function Hoe:Activate(Player,Block)
	local BlockList = _G.GetBlockList()
	local Block = BlockList[Block]
	
	if not Block.Tilled then
		Block.Tilled = true
		
		Block:UpdateClient("Tilled")
	end
end

return Hoe

