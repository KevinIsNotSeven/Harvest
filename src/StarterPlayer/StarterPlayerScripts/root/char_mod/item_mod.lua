local r = _G.root
local item_mod = {}
item_mod.inventory = {}
item_mod.inventoryslots = 5

function item_mod.AddItem(inventory, itemobj)
	local slot = item_mod.CanAddItem(itemobj)
	item_mod.inventory[slot] = itemobj
end

function item_mod.CanAddItem(itemobj)
	for x=1,item_mod.inventoryslots do
		if not item_mod.inventory[x]then
			return x
		end
	end
end

function item_mod.MakeItemObj(ItemType,ItemName)
	local Object = require(r.as.Object)

	local Item = Object.new("Item",ItemType,ItemName)
	return Item
end

function item_mod.AddItemFromName(name)
	item_mod.AddItem(item_mod.inventory, item_mod.MakeItemObj(name))
end

--item_mod.AddItemFromName("Scuffler")

return item_mod