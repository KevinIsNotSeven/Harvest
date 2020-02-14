local function SellItem(Player,Slot)
    local Server = _G.GetServer()
    local Player = Server.PlayerList[Player.userId]
    local Item = Player.SaveData.Hotbar[Slot]
    Item:Sell()
    Player.SaveData.Hotbar[Slot]["1"] = "None"
end

return SellItem