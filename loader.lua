local url_raw_github = "https://raw.githubusercontent.com/MaGiXxScripter0/wheathub"

local games_supported = {
    [7499189111] = "/main/scripts/Encounters.lua",
    [7501699167] = "/main/scripts/Encounters.lua",
}

return function()
    local url_script = games_supported[game.PlaceId]
    if not url_script then
        return game.Players.LocalPlayer:Kick("\nNo Supported Game")
    end
    loadstring(game:HttpGet(url_raw_github .. url_script))()
end
