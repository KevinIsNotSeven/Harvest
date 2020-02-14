local Object = require(script.Parent)
local ItemData = require(script.ItemData)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Attributes = {"Activatable","Stackable","Value","DisplayName"}

local Item = {}
Item.__index = Item
setmetatable(Item,{__index = Object})

function Item.new(ItemType,ItemName,...)
	local Module = require(script[ItemType])
	local NewItem = Module.new(ItemName,...)
	
	NewItem.ItemType = ItemType
	NewItem.ItemName = ItemName

	if ReplicatedStorage.Items[NewItem.ItemType .. "s"]:FindFirstChild(ItemName) then
		NewItem.Model = ReplicatedStorage.Items[NewItem.ItemType .. "s"][ItemName]
	else
		NewItem.Model = ReplicatedStorage.Items.Template
	end

	for i,Attribute in pairs(Attributes) do
		if ItemData[NewItem.ItemType][NewItem.ItemName][Attribute] then
			NewItem[Attribute] = ItemData[NewItem.ItemType][NewItem.ItemName][Attribute]
		else
			NewItem[Attribute] = ItemData[NewItem.ItemType][Attribute]
		end
	end

	return NewItem
end

function Item:Sell(Player)
	Player.SaveData.Goins = Player.SaveData.Goins + self.Value

	self:Destroy()
end

function Item:ActivateClient()
	print("how")
end

return Item

