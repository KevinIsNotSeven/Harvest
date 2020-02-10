local collision_mod = {}

function collision_mod.Check(char)
	local height = 2
	local radius = 1
	char.Ground = nil
	if char.vel.Y < .1 then--floor cast
		local f1,f2,f3 = collision_mod.Ray(Ray.new(char.pos, Vector3.new(0,-height) ), {char.Pal} )
		char.Ground = f1
		char.tojump = false
		if f1 then
			char.pos = char.pos - char.pos*Vector3.new(0,1) + Vector3.new(0,f2.Y+height)
			char.vel = char.vel*Vector3.new(1,0,1)
		end
	end
	
	local numrings = 8
	for y=0,6 do--body cast
		for x=0,numrings-1 do
			local point = CFrame.Angles(0,x/numrings*math.pi*2,0)
			local origin = char.pos+Vector3.new(0,-.8+y/2)
			local f1,f2,f3 = collision_mod.Ray(Ray.new(origin, point.LookVector*radius), {char.Pal} )
			if f1 and f1.CanCollide then
				workspace.bruh2.CFrame = CFrame.new(f2)
				char.pos = char.pos - point.LookVector*(radius- (f2-origin).Magnitude )
			end
		end
	end
	
	if char.vel.Y > -.1 then--ceiling cast
		local f1,f2,f3 = collision_mod.Ray(Ray.new(char.pos, Vector3.new(0,height) ), {char.Pal} )
		if f1 then
			char.pos = char.pos - char.pos*Vector3.new(0,1) + Vector3.new(0,f2.Y-height)
			char.vel = char.vel*Vector3.new(1,0,1)
		end
	end
	
	if char.pos.Y < -50 then
		char.pos = Vector3.new(0,10)
		char.vel = Vector3.new()
	end
end

function collision_mod.Ray(ray,ignore)
	local f1,f2,f3 = workspace:FindPartOnRayWithIgnoreList(ray,ignore)
	if f1 and not f1.CanCollide then
		ignore[#ignore+1] = f1
		return collision_mod.Ray(ray,ignore)
	end
	return f1,f2,f3
end

return collision_mod