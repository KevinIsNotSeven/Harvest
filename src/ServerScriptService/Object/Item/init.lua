local Object = require(script.Parent)
local ItemData = require(script.ItemData)

local Item = {}
Item.__index = Item
setmetatable(Item,{__index = Object})

function Item.new(ItemType,Player,...)
	local Module = require(script[ItemType])
	local NewItem = Module.new(...)
	
	NewItem.ItemType = ItemType
	NewItem.Player = Player
	
	NewItem.Useable = false

	return NewItem
end

function Item:Sell()
	local Value = ItemData[self.ItemType][self.ItemName].Value

	self.Player.SaveData.Goins = self.Player.SaveData.Goins + Value

	self:Destroy()
end

return Item

