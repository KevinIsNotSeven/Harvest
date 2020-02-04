local r = _G.root
local ui_mod = {}
ui_mod.GameUI = game:GetService("StarterGui").GameUI:Clone()
ui_mod.GameUI.Parent = r.lp.PlayerGui
local UI = ui_mod.GameUI
local cam = Instance.new("Camera")
cam.CFrame = CFrame.new(Vector3.new(2,2,2),Vector3.new() )
cam.Parent = UI

function ui_mod.Step()
	
end

function ui_mod.Render()
	
end

function ui_mod.MakeItemButton(Model, x)
	local ItemButton = script.ItemButton:Clone()
	ItemButton.ViewportFrame.CurrentCamera = cam
	Model = Model:Clone()
	Model.Parent = ItemButton.ViewportFrame
	local Model = ui_mod.MakeCopy(Model, ItemButton)
	ItemButton.MouseButton1Down:Connect(function()
		r.char.anim.Till:Play()
		local block = r.placing_mod.GetBlock()
		r.char.facing = CFrame.new(Vector3.new(), block.Part1.Position*Vector3.new(1,0,1)- r.char.pos*Vector3.new(1,0,1))
		r.item_mod.inventory[tostring(x)]:Test(tostring(x), block)
	end)
	ItemButton.ItemSlot.Value = x or 0
	return ItemButton
end

function ui_mod.MakeCopy(Model, ItemButton)
	local Part = Instance.new("Part")
	local orientation, size = Model:GetBoundingBox()
	Part.Size = size
	Part.CFrame = orientation
	Part.Parent = Model
	Part.Transparency = 1
	Model.PrimaryPart = Part
	Model:SetPrimaryPartCFrame(CFrame.new())
end

function ui_mod.Breh()
	for x=1,5 do
		local item = r.item_mod.inventory[tostring(x)]
		if item~="None" then
			local ItemButton = ui_mod.MakeItemButton(item.Model, x)
			ItemButton.Parent = UI.Inventory.Hotbar
			ui_mod.MakeItemButton(item.Model, x)
		end
	end
end

return ui_mod