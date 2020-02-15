--very lazy and boring code
local clocktime = 0
local lighting = workspace.Lighting
local Daytype = workspace.LightingNormal.bruh

function findclosestkeypoint(keypoints)
	local t = clocktime/24
	local thiskeypoint, nextkeypoint = keypoints[1],keypoints[2]
	for i,v in pairs(keypoints)do
		if t>=v.Time then
			thiskeypoint = v
			nextkeypoint = keypoints[i+1] or keypoints[1]
		end
	end
	local diff = (nextkeypoint.Time-thiskeypoint.Time)
	local start = thiskeypoint.Time
	local ended = nextkeypoint.Time-start
	return thiskeypoint.Value:Lerp(nextkeypoint.Value, (t-start)/diff)
end

while true do
	clocktime = clocktime + wait()/2
	if clocktime>24 then
		clocktime = clocktime - 24
	end
	local date = os.date("*t")
	clocktime = date.hour-1 + date.min/60 + date.sec/3600
	--clocktime = workspace.clocktime.Position.X/-50*24
	local monthtime = clocktime + date.day
	
	lighting.sunmoon.CFrame = CFrame.Angles(clocktime/12*math.pi+math.pi,0,0)
	lighting.stars.CFrame = CFrame.Angles(monthtime/12*math.pi,0,0)
	lighting.sky.Color = findclosestkeypoint(Daytype.SkyColor.ParticleEmitter.Color.Keypoints)
	lighting.stars.Transparency = findclosestkeypoint(Daytype.StarTransparency.ParticleEmitter.Color.Keypoints).r
	game.Lighting.Ambient = findclosestkeypoint(Daytype.Ambient.ParticleEmitter.Color.Keypoints)
	--workspace.clocktime.SurfaceGui.TextLabel.Text = math.floor(clocktime)
end