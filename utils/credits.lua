return function(window_ui_rayfield)
    local Credits_Tab = window_ui_rayfield:CreateTab("Credits")

    Credits_Tab:CreateButton({
       Name = "Discord Invite: wsbyxxCQuW",
       Callback = function()
           if setclipboard then
              setclipboard("https://discord.gg/wsbyxxCQuW")
           end
       end,
    })

    Credits_Tab:CreateLabel("Owner: MaGiXx#6964")
end
