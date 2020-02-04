local function LoadClient()
    print("wow1!")
    _G.root = require(script.Parent.Parent.Parent.root)
    _G.root.Start()
    print("wow!")
end

return LoadClient