if _G.CiwaLoading then 
    return
end
_G.CiwaLoading = true
local VERSION = "1.0"
local HUB_NAME = "CiwaHub"
local games = {
    [6739698191] = "https://raw.githubusercontent.com/CiwaFps/Ciw-/refs/heads/main/Game/Ciwa%20x%20VD.lua",
}
local UNIVERSAL_SCRIPT = "https://raw.githubusercontent.com/CiwaFps/Ciw-/refs/heads/main/Game/Uwu.lua"
local universeId = game.GameId
local scriptURL  = games[universeId]
if scriptURL then
    local ok, err = pcall(function()
        loadstring(game:HttpGet(scriptURL))()
    end)
    if not ok then
        warn(string.format("[%s] Gagal load script khusus: %s", HUB_NAME, tostring(err)))
    end
else
    local ok, err = pcall(function()
        loadstring(game:HttpGet(UNIVERSAL_SCRIPT))()
    end)
    if not ok then
        warn(string.format("[%s] Gagal load script bebas: %s", HUB_NAME, tostring(err)))
    end
end
task.wait(5)
_G.CiwaLoading = false
