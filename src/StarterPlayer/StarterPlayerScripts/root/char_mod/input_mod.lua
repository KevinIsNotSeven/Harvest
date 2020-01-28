local r = _G.root
local input_mod = {}

r.UIS.InputBegan:Connect(function(inp)
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
	elseif k == "B" then
		r.placing_mod.Place()
	elseif k == "N" then
		r.placing_mod.Remove()
	elseif k == "G"then 
	end
end)

return input_mod