local HttpService = game:GetService("HttpService")
request = http_request or request or HttpPost or syn.request

local function join_server(code)
    if request == nil then
        return
    end
    return request({
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",
        Body = HttpService:JSONEncode({
            cmd = "INVITE_BROWSER",
            args = {
              code = code
            },
            nonce = string.lower(HttpService:GenerateGUID(false))
        }),
        Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }
    })
end

