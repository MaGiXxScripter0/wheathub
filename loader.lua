local url_raw_github = "https://raw.githubusercontent.com/MaGiXxScripter0/wheathub"
-- 7
local games_supported = {
    [7499189111] = "/main/scripts/Encounters.lua",
    [7501699167] = "/main/scripts/Encounters.lua",
    [10446125875] = "/main/scripts/AnimeFruitSimulator.lua",
    [11542692507] = "/main/scripts/AnimeSoulsSimulator.lua",
    [10036492542] = "/main/scripts/Get%20Muscles%20Simulator.lua",
    [8540346411] = "/main/scripts/Rebirth%20Champions%20X.lua",
    [5712833750] = "/main/scripts/Animal%20Simulator.lua",
    [11846163207] = "/main/scripts/Mage%20Tycoon.lua",
    [9498006165] = "/main/scripts/Tapping%20Simulator.lua",
    [4893679160] = "/main/scripts/Big%20Brain%20Simulator.lua",
    [11746859781] = "/main/scripts/Bubble%20Gum%20Clicker.lua"
}

return function()
    local url_script = games_supported[game.PlaceId]
    if not url_script then
        return game.Players.LocalPlayer:Kick("\nNo Supported Game")
    end
    loadstring(game:HttpGet(url_raw_github .. url_script))()
end
