while true do
	local LagTime = .1
	local t = tick()
	while tick()-t<LagTime do end
	game["Run Service"].RenderStepped:Wait()
end