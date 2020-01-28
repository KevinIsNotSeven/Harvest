local function ActivateHotbar(Player,Slot,...)
	local Server = _G.GetServer()
	local Player = Server.PlayerList[Player.userId]
	
	Player.SaveData.Hotbar[Slot]:Activate(...)
end

return ActivateHotbar