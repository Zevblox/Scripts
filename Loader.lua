if ZEV_LOADED then
    return
end

local cloneref = cloneref or function(o) return o end
COREGUI = cloneref(game:GetService("CoreGui"))

if not game:IsLoaded() then
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = COREGUI
    notLoaded.Text = "Zevblox is waiting for the game to load"
    game.Loaded:Wait()
    notLoaded:Destroy()
end

loadstring(game:HttpGet('https://raw.githubusercontent.com/Zevblox/Scripts/refs/heads/main/FindScript.lua'))()

pcall(function() getgenv().ZEV_LOADED = true end)
