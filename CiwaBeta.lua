if _G.CiwaLoading then 
    return
end

_G.CiwaLoading = true

local HUB_NAME = "CiwaHub"
local games = {
    [6739698191] = "https://raw.githubusercontent.com/CiwaFps/Ciw-/refs/heads/main/Game/Ciwa%20x%20VD.lua",
}
local UNIVERSAL_SCRIPT = "https://raw.githubusercontent.com/CiwaFps/Ciw-/refs/heads/main/Game/Uwu.lua"

-- Gunakan PlaceId jika ID di atas adalah ID dari URL game
local currentId = game.PlaceId
local scriptURL = games[currentId] or UNIVERSAL_SCRIPT

local ok, err = pcall(function()
    loadstring(game:HttpGet(scriptURL))()
end)

if not ok then
    warn(string.format("[%s] Gagal load script: %s", HUB_NAME, tostring(err)))
end

-- Tunggu sebentar sebelum mengizinkan eksekusi ulang
task.wait(5)
_G.CiwaLoading = false
