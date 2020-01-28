local Object = require(script.Parent)

local Item = {}
Item.__index = Item
setmetatable(Item,{__index = Object})

function Item.new(ItemType,...)
	local Module = require(script[ItemType])
	local NewItem = Module.new(...)
	
	NewItem.ItemType = ItemType
	
	return NewItem
end

return Item

