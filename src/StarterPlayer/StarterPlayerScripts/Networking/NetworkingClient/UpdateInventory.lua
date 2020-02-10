local function UpdateInventory(Slot,Item)
    local Inventory = _G.root.item_mod.inventory

    if Item ~= "None" then
        Inventory[Slot] = _G.root.item_mod.MakeItemObj(Item.ItemType,Item.ItemName)
        
        _G.root.ui_mod.Breh()
    end

end

return UpdateInventory