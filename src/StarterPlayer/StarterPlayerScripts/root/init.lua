local r = {}

function r.Start()
	r.running = true
	r.lp = game.Players.LocalPlayer
	r.ms = r.lp:GetMouse()
	r.w = workspace
	r.ControlModule = require(script.Parent:WaitForChild("PlayerModule").ControlModule)
	r.RS = game:GetService("RunService")
	r.RSW = r.RS.Heartbeat
	r.UIS = game:GetService("UserInputService")
	r.as = game:GetService("ReplicatedStorage")
	--r.ui = r.lp:WaitForChild("PlayerGui"):WaitForChild("GameUI")
	r.gravity = Vector3.new(0,-1)
	
	r.char_mod = require(script.char_mod)
	r.input_mod = require(script.char_mod.input_mod)
	r.anim_mod = require(script.char_mod.anim_mod)
	r.collision_mod = require(script.char_mod.collision_mod)
	r.placing_mod = require(script.char_mod.placing_mod)
	r.ui_mod = require(script.char_mod.ui_mod)
	
	r.char = r.char_mod.New(true)
	workspace.CurrentCamera.CameraSubject = r.char.Pal
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	
	function r.PreStep()
		local input = r.ControlModule:GetMoveVector()
		if input.Magnitude > .2 then
			if input.Magnitude > 1 then
				input = input.Unit
			end
			local cfcam = CFrame.new(Vector3.new(), r.w.CurrentCamera.CFrame.LookVector*Vector3.new(1,0,1))
			local cfinp = CFrame.new(Vector3.new(), input)
			input = (cfinp*cfcam).LookVector * input.Magnitude
		else
			input = Vector3.new()
		end
		
		r.char.camerainput = input
		r.char.input = r.ControlModule:GetMoveVector()
	end
	
	function r.Step()
		r.char.Step()
	end
	
	function r.PostStep()
		r.char.Render()
	end

	while r.running do
		local DoStepTick = tick()
		--wait()
		r.RSW:Wait()
		if not r.StepFrames then
			r.PreStep()
			while DoStepTick < tick() do
				DoStepTick = DoStepTick + 1/120
				r.Step()
			end
			r.PostStep()
		end
	end
end

return r