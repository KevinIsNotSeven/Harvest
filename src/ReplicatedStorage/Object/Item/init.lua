local Object = require(script.Parent)
local ItemData = require(script.ItemData)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Item = {}
Item.__index = Item
setmetatable(Item,{__index = Object})

function Item.new(ItemType,ItemName,...)
	local Module = require(script[ItemType])
	local NewItem = Module.new(ItemName,...)
	
	NewItem.ItemType = ItemType
	
	NewItem.Useable = false

	NewItem.Model = ReplicatedStorage.Items[NewItem.ItemType .. "s"][ItemName]:Clone()

	return NewItem
end

function Item:Sell()
	local Value = ItemData[self.ItemType][self.ItemName].Value

	self.Player.SaveData.Goins = self.Player.SaveData.Goins + Value

	self:Destroy()
end

return Item

