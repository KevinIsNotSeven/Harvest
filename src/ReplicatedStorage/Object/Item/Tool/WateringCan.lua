local Object = require(script.Parent.Parent.Parent)
local Tool = require(script.Parent)

local WateringCan = {}
WateringCan.__index = WateringCan
setmetatable(WateringCan,{__index = Tool})

function WateringCan.new()
	local NewWateringCan = {}
	setmetatable(NewWateringCan,WateringCan)
	
	return NewWateringCan
end

function WateringCan:Activate(Player,Block)
	local BlockList = _G.GetBlockList()
	local Block = BlockList[Block]

	Block:Water(Player)
end

function WateringCan:ActivateClient(Slot)
	local r = _G.root

	local block = r.placing_mod.GetBlock()
	r.char.facing = CFrame.new(Vector3.new(), block.PrimaryPart.Position*Vector3.new(1,0,1)- r.char.pos*Vector3.new(1,0,1))

	Object.NetworkingEvent:FireServer("ActivateHotbar",Slot,block)
end

return WateringCan

