local Object = require(script.Parent)

local Item = {}
Item.__index = Item
setmetatable(Item,{__index = Object})

function Item.new(ItemType,Player,...)
	local Module = require(script[ItemType])
	local NewItem = Module.new(...)
	
	NewItem.ItemType = ItemType
	NewItem.Player = Player
	
	return NewItem
end

return Item

