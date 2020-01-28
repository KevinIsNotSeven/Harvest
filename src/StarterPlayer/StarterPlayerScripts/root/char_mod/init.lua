local r = _G.root
local char_mod = {}
char_mod.chars = {}
local testtick = 0
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function char_mod.New(client)
	local char = {}
	char.cool = true
	char.client = client
	char.pos = Vector3.new(0,10)
	char.vel = Vector3.new()
	char.Ground = nil
	char.tojump = false
	char.Pal = r.as.Pal:Clone()
	char.Pal.Parent = workspace
	char.input = Vector3.new()
	char.camerainput = Vector3.new()
	char.facing = CFrame.new()
	char.toface = CFrame.new()
	char.anim = r.anim_mod.New(char)
	char.anim.Idle:Play()
	char.walking = false
	char.terp = false
	char.Placing = ReplicatedStorage.Plants.Flower.Placement:Clone()
	char.Placing.Parent = workspace
	--bruh!
	
	require(script.char_step_mod)(char)
	require(script.char_func_mod)(char)
	char.Build()
	
	char_mod.chars[#char_mod.chars+1] = char
	return char
end


return char_mod