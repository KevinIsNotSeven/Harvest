local r = _G.root
return function(char)
	function char.Step()
		r.ui_mod.Step()
		char.vel = char.vel + r.gravity/100
		if char.terp then
			char.vel = char.vel + Vector3.new(char.camerainput.X,0,char.camerainput.Z)/10--movement
		else
			char.vel = char.vel + Vector3.new(char.camerainput.X,0,char.camerainput.Z)--movement
		end
		
		if char.camerainput.Magnitude > .2 then
			char.facing = CFrame.new(Vector3.new(), char.camerainput)
			if not char.walking then char.walking = true
				char.anim.Walk:Play()
			end
		else
			if char.walking then char.walking = false
				char.anim.Walk:Stop()
			end
		end
		char.toface = char.toface:Lerp(char.facing, .2)
		
		char.pos = char.pos + char.vel/10
		if char.terp then
			char.vel = Vector3.new(char.vel.X*.9, char.vel.Y, char.vel.Z*.9)--dampening / friction
		else
			char.vel = Vector3.new(0, char.vel.Y, 0)--dampening / friction
		end
		
		r.collision_mod.Check(char)
	end
end