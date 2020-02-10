local function ActivateHotbar(Player,Slot,...)
	local Server = _G.GetServer()
	local Player = Server.PlayerList[Player.userId]
	local Item = Player.SaveData.Hotbar[tostring(Slot)]

	if Item.Useable then
		Item:Activate(Player,...)
	end
end

return ActivateHotbar