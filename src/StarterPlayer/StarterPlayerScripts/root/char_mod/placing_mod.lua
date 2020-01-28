local r = _G.root
local placing_mod = {}

local NetworkingEvent = r.as.Networking.NetworkingEvent

function placing_mod.Render()
	local char = r.char
	local cf = placing_mod.GetBlock()
	cf = CFrame.new(cf) * CFrame.Angles(0,math.floor(math.atan2(char.facing.lookVector.X,char.facing.lookVector.Z)/math.pi*2+.5)*math.pi/2 ,0)
	char.Placing:SetPrimaryPartCFrame(cf)
end

function placing_mod.GetBlock()
	local angle = math.floor(math.atan2(r.char.facing.LookVector.X, r.char.facing.LookVector.Z)/math.pi*2+.5)
	local angles = {[0]=0,[1]=1,[2]=2,[-2]=2,[-1]=3 }
	angle=angles[angle]
	local cf = r.char.pos + CFrame.Angles(0,angle*math.pi/2,0).LookVector*-3
	--cf = Vector3.new(math.floor(cf.X/3)*3+1.5,r.char.pos.Y,math.floor(cf.Z/3)*3+1.5)
	--cf = Vector3.new()
	local f1,f2,f3 = workspace:FindPartOnRayWithWhitelist(Ray.new(cf, Vector3.new(0,-6) ), {workspace.Blocks} )
	if f1 then
		return f1.Position, f1, angle
	else
		return Vector3.new()
	end
end

function placing_mod.Place()
	local _,block,rot = placing_mod.GetBlock()--that is dirt
	if block then
		NetworkingEvent:FireServer("PlacePlant", block.Parent, "Flower", rot)
	end
end

function placing_mod.Remove()
	local _,block = placing_mod.GetBlock()--that is dirt
	if block then
		NetworkingEvent:FireServer("RemovePlant", block.Parent)
	end
end

return placing_mod