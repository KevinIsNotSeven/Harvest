local function ActivateHotbar(Player,Slot,...)
	local Server = _G.GetServer()
	local Player = Server.PlayerList[Player.userId]
	print(Slot)
	Player.SaveData.Hotbar[tostring(Slot)]:Activate(Player,...)
end

return ActivateHotbar