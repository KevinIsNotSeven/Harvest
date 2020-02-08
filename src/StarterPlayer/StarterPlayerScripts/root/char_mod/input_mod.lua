local r = _G.root
local input_mod = {}

local stupidfuckingtable = {
	One = "1";
	Two = "2";
	Three = "3";
	Four = "4";
	Five = "5";
}

r.UIS.InputBegan:Connect(function(inp,processed)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		if r.item_mod.inventory[r.char.SelectedSlot] ~= "None" then
			r.item_mod.inventory[r.char.SelectedSlot]:ActivateClient()
		end
	elseif inp.UserInputType == Enum.UserInputType.Keyboard then
		local k = inp.KeyCode.Name

		if k == "Space" then
			r.char.Jump()
		elseif k == "E"then
			r.char.UseItem()
		elseif k == "Q" then
			r.StepFrames = true
			r.PreStep()
			r.Step()
			r.PostStep()
		elseif k == "E" then
			r.StepFrames = false
		elseif k == "T" then
			r.char.terp = not r.char.terp
		elseif k == "N" then
			r.placing_mod.Remove()
		elseif k == "G"then
			r.char.SellItem()
		elseif k == "One" or k == "Two" or k == "Three" or k == "Four" or k == "Five" then
			r.char.SelectedSlot = stupidfuckingtable[k]
		end
	end
end)

return input_mod