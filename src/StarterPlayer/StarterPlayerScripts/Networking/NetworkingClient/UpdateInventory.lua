local function UpdateInventory(Slot,Item,Amount)
    local Inventory = _G.root.item_mod.inventory

    if Item ~= "None" then
        Inventory[Slot]["1"] = _G.root.item_mod.MakeItemObj(Item.ItemType,Item.ItemName)
        Inventory[Slot]["2"] = Amount
    else
        Inventory[Slot]["1"] = "None"
        Inventory[Slot]["2"] = 0
    end

    _G.root.ui_mod.Breh()
end

return UpdateInventory