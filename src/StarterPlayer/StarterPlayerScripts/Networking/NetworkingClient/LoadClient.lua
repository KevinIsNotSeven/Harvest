local function LoadClient()
    _G.root = require(script.Parent.Parent.Parent.root)
    _G.root.Start()
end

return LoadClient