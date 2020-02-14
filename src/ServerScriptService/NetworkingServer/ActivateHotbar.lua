local function ActivateHotbar(Player,Slot,...)
	local Server = _G.GetServer()
	local Player = Server.PlayerList[Player.userId]
	local Item = Player:GetItem(Slot)

	if Item.Activatable then
		Item:Activate(Player,...)
	end
end

return ActivateHotbar