-- Settings

local aimbot = {
    Enabled = false,
    Key = Enum.UserInputType.MouseButton2,
    Players = false,
    PlayerPart = 'Head',
    FriendlyPlayers = {},
    TeamCheck = false,
    AliveCheck = false,
    VisibilityCheck = false,
    Smoothing = 0,
    SmoothingMethod = 0,
    Offset = {0, 0},
    FOV = 200,
    ShowFOV = false,
    CustomParts = {},
    FOVCircleColor = Color3.fromRGB(255, 255, 255)
}

-- Variables

local UserInputService = game:service'UserInputService'
local Players = game:service'Players'
local RunService = game:service'RunService'
local plr = game:service'Players'.LocalPlayer
local mouse = plr:GetMouse()
local keypressed = false
local fovcircle = Drawing.new('Circle')
fovcircle.Filled = false
fovcircle.Thickness = 1

-- Functions

aimbot.GetClosestPart = function()
    local target
    
    local parts = {}

    for i,v in pairs(aimbot.CustomParts) do
        if v:IsA'Part' or v:IsA'BasePart' or v:IsA'MeshPart' then
            table.insert(parts, v)
        end
    end
    
    if aimbot.Players == true then
        for i,v in pairs(Players:GetPlayers()) do
            if not table.find(aimbot.FriendlyPlayers, v.Name) and v.Name ~= plr.Name then
                if aimbot.AliveCheck and v.Character and v.Character:FindFirstChildWhichIsA'Humanoid' and v.Character:FindFirstChildWhichIsA'Humanoid'.Health < 1 then
                    continue
                end
                if aimbot.TeamCheck and v.TeamColor == plr.TeamColor then
                    continue
                end
                if v.Character and v.Character:FindFirstChild(aimbot.PlayerPart) then
                    local part = v.Character[aimbot.PlayerPart]
                    if aimbot.VisibilityCheck then
                        local params = RaycastParams.new()
                        params.FilterType = Enum.RaycastFilterType.Blacklist
                        params.IgnoreWater = true
                        params.FilterDescendantsInstances = {part.Parent, plr.Character}
                        local raycast = workspace:Raycast(workspace.CurrentCamera.CFrame.p, (part.CFrame.p - workspace.Camera.CFrame.p), params)
                        if raycast then
                            return
                        end
                    end
                    table.insert(parts, v.Character[aimbot.PlayerPart])
                end
            end
        end
    end
    
    for i,v in pairs(parts) do
        local pos = workspace.CurrentCamera:WorldToScreenPoint(v.CFrame.p)
        local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
        if distance <= aimbot.FOV and pos.Z >= 0 then
            if not target then
                target = {Part = v, Position = pos, Distance = distance}
            else
                if distance < target.Distance then
                    target = {Part = v, Position = pos, Distance = distance}
                end       
            end
        end
    end

    return target
end

aimbot.Aim = function(x, y, smooth)
    if not smooth then
        smooth = aimbot.Smoothing
    end
    if aimbot.SmoothingMethod == 0 then
        mousemoverel((x + aimbot.Offset[1] - mouse.X) / (1 * (smooth + 1)), (y + aimbot.Offset[2] - mouse.Y) / (1 * (smooth + 1)))
    else
        mousemoverel((x + aimbot.Offset[1] - mouse.X) / (smooth + 1), (y + aimbot.Offset[2] - mouse.Y) / (smooth + 1))
    end
end

-- Key Pressing

UserInputService.InputBegan:Connect(function(input)
    if not aimbot.Key then return end
    if UserInputService:GetFocusedTextBox() then
        return
    end
    if input.KeyCode == aimbot.Key or input.UserInputType == aimbot.Key then
        keypressed = true
    end 
end)

UserInputService.InputEnded:Connect(function(input)
    if not aimbot.Key then return end
    if UserInputService:GetFocusedTextBox() then
        return
    end
    if input.KeyCode == aimbot.Key or input.UserInputType == aimbot.Key then
        keypressed = false
    end 
end)

-- Loops

RunService.RenderStepped:Connect(function() -- FOV Updating
    fovcircle.Visible = aimbot.ShowFOV
    fovcircle.Color = aimbot.FOVCircleColor
    fovcircle.Radius = aimbot.FOV
    fovcircle.Position = Vector2.new(mouse.X + aimbot.Offset[1], mouse.Y + 35 + aimbot.Offset[2])
end)

RunService.RenderStepped:Connect(function() -- Aiming
    if aimbot.Enabled and keypressed then
        local part = aimbot.GetClosestPart()
        if part then
            aimbot.Aim(part.Position.X, part.Position.Y, aimbot.Smoothing)
        end
    end
end)

return aimbot
