local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

local Offset_Head = Vector3.new(0, 0.5, 0)
local Offset_Leg = Vector3.new(0,5,0)

local esp_lib = {
    players = {}
}

esp_lib.TeamCheck = false
esp_lib.PlayerEnabled = true

esp_lib.TracerFromType = "Top"
esp_lib.TracerToType = "Center"

esp_lib.Tracer = true
esp_lib.Name = true
esp_lib.Distance = true
esp_lib.Box = true
esp_lib.HealthBar = true

function esp_lib:PlayerAdd(v)
    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new(1,1,1)
    Box.Thickness = 2
    Box.Transparency = .7
    Box.Filled = false

    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.new(0,0,0)
    BoxOutline.Thickness = 6
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 2
    HealthBar.Filled = true
    HealthBar.Transparency = .7
    HealthBar.Visible = false
    
    local HealthBarOutline = Drawing.new("Square")
    HealthBarOutline.Thickness = 6
    HealthBarOutline.Filled = false
    HealthBarOutline.Color = Color3.new(0,0,0)
    HealthBarOutline.Transparency = 1
    HealthBarOutline.Visible = false

    local TracerOutline = Drawing.new("Line")
    TracerOutline.Thickness = 3
    TracerOutline.Color = Color3.new(0,0,0)
    TracerOutline.Visible = false

    local Tracer = Drawing.new("Line")
    Tracer.Thickness = 1
    Tracer.Color = Color3.new(1,1,1)
    Tracer.Visible = false

    local TextName = Drawing.new("Text")
    TextName.Size = 18
    TextName.Center = true
    TextName.Outline = true
    TextName.OutlineColor = Color3.new(0,0,0)
    TextName.Color = Color3.new(1,1,1)
    TextName.Text = v.Name
    TextName.Visible = false

    local TextDistance = Drawing.new("Text")
    TextDistance.Size = 18
    TextDistance.Center = true
    TextDistance.Outline = true
    TextDistance.OutlineColor = Color3.new(0,0,0)
    TextDistance.Color = Color3.new(1,1,1)
    TextDistance.Visible = false

    local function Visible_All(bool)
        BoxOutline.Visible = bool
        Box.Visible = bool
        HealthBarOutline.Visible = bool
        HealthBar.Visible = bool
        Tracer.Visible = bool
        TracerOutline.Visible = bool
        TextName.Visible = bool
        TextDistance.Visible = bool
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        if self.PlayerEnabled == false then
            return Visible_All(false)
        end
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character.Humanoid.Health > 0 then
            local Vector, onScreen = CurrentCamera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
                        
            local RootPart = v.Character.HumanoidRootPart
            local Head = v.Character.Head
            local RootPosition, RootVis = CurrentCamera:worldToViewportPoint(RootPart.Position)
            local HeadPosition = CurrentCamera:worldToViewportPoint(Head.Position + Offset_Head)
            local LegPosition = CurrentCamera:worldToViewportPoint(RootPart.Position - Offset_Leg)

            if onScreen then
                Box.Size = Vector2.new(2000/RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                Box.Position = Vector2.new(RootPosition.X - Box.Size.X/2, RootPosition.Y - Box.Size.Y/2)

                BoxOutline.Size = Vector2.new(2000/RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X/2, RootPosition.Y - BoxOutline.Size.Y/2)
                
                if self.Box == true then
                    BoxOutline.Visible = true
                    Box.Visible = true
                else
                    Box.Visible = false
                    BoxOutline.Visible = false
                end

                if self.HealthBar == true then
                    HealthBarOutline.Size = Vector2.new(4, HeadPosition.Y - LegPosition.Y)
                    HealthBarOutline.Position = Vector2.new((RootPosition.X + Box.Size.X/2) + 6, BoxOutline.Position.Y)
                    HealthBarOutline.Visible = true

                    HealthBar.Size = Vector2.new(4, (HeadPosition.Y - LegPosition.Y)/(v.Character.Humanoid.MaxHealth/math.clamp(v.Character.Humanoid.Health, 0, v.Character.Humanoid.MaxHealth)))
                    HealthBar.Position = Vector2.new((RootPosition.X + Box.Size.X/2) + 6, Box.Position.Y + (1/HealthBar.Size.Y))
                    HealthBar.Color = Color3.fromHSV((v.Character.Humanoid.Health/v.Character.Humanoid.MaxHealth)*.15, 0.4, 0.8) 
                    HealthBar.Visible = true
                else
                    HealthBar.Visible = false
                    HealthBarOutline.Visible = false
                end
                
                if self.Name == true then
                    TextName.Position = Vector2.new(BoxOutline.Position.X + Box.Size.X/2, BoxOutline.Position.Y + 6)
                    TextName.Visible = true
                else
                    TextName.Visible = false
                end
                
                if self.Distance == true then
                    local distance = math.round((LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude/10)

                    TextDistance.Text = "Distance: " .. distance .. "m"
                    TextDistance.Position = Vector2.new(BoxOutline.Position.X + Box.Size.X/2, BoxOutline.Position.Y + 20)
                    TextDistance.Visible = true
                else
                    TextDistance.Visible = false
                end

                if self.Tracer == true then
                    local ViewportSize = workspace.CurrentCamera.ViewportSize
                    
                    if self.TracerFromType == "Bottom" then
                        Tracer.From = Vector2.new(ViewportSize.X/2, ViewportSize.Y)
                    elseif self.TracerFromType == "Top" then
                        Tracer.From = Vector2.new(ViewportSize.X/2, 0)
                    elseif self.TracerFromType == "Center" then
                        Tracer.From = Vector2.new(ViewportSize.X/2, ViewportSize.Y/2)
                    end

                    if self.TracerToType == "Bottom" then
                        Tracer.To = Vector2.new(BoxOutline.Position.X + Box.Size.X/2, BoxOutline.Position.Y)
                    elseif self.TracerToType == "Top" then
                        Tracer.To = Vector2.new(BoxOutline.Position.X + Box.Size.X/2, RootPosition.Y + Box.Size.Y/2)
                    elseif self.TracerToType == "Center" then
                        Tracer.To = Vector2.new(BoxOutline.Position.X + Box.Size.X/2, RootPosition.Y)
                    end

                    TracerOutline.From = Tracer.From
                    TracerOutline.To = Tracer.To
                    
                    TracerOutline.Visible = true
                    Tracer.Visible = true
                else
                    TracerOutline.Visible = false
                    Tracer.Visible = false
                end

                if self.TeamCheck == true then
                    if v.TeamColor == LocalPlayer.TeamColor then
                        Visible_All(false)
                    else
                        Visible_All(true)
                    end
                end
            else
                Visible_All(false)
            end
        else
            Visible_All(false)
        end
    end)
    return table.insert(self.players, v)
end

return esp_lib
