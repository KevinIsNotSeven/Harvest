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

		Block:UpdateClient(Player,"Tilled")
	end
end

function Hoe:ActivateClient()
	local r = _G.root

	r.char.anim.Till:Play()
	local block = r.placing_mod.GetBlock()
	r.char.facing = CFrame.new(Vector3.new(), block.Part1.Position*Vector3.new(1,0,1)- r.char.pos*Vector3.new(1,0,1))

	Object.NetworkingEvent:FireServer("ActivateHotbar",r.char.SelectedSlot,block)
end

return Hoe

