--[[
Hello! This script was made by yesok#3877 & DestinyTakes#0001!
If you're reading this, nope, this wasn't a mistake; I did make this open source.
The obfuscation was wayy too laggy for this script so I decided to make it open.
Have fun using this script!
--]]

warn("Loading UI")

local Library=loadstring(game:HttpGet("https://raw.githubusercontent.com/yesok3877/not-wallys-ui-lib/master/UILib", true))()

local WindowName="Celestial v1.8c"
local WindowYSize=545
local WindowTheme=Color3.fromRGB(23, 121, 255)
local Window=Library:Window(WindowName, WindowTheme, WindowYSize)

Window:Label("yesok#3877", WindowTheme)
Window:Label("DestinyTakes#0001", WindowTheme)
Window:Label("discord.gg/tD2nXud", Color3.fromRGB(114,137,218))

local Main=Window:Tab("Aimbot")
local Visuals=Window:Tab("Visuals")
local Client=Window:Tab("Client")
local UISettings=Window:Tab("UI Settings")

local Settings=Main:Section("Settings")
local SSA=Main:Section("Silent Aim")
local Configuration=Main:Section("Configuration")
local KBM=Main:Section("Keybinds")

local SMC=Client:Section("Combat")
local ICC=Client:Section("Input")
local AKC=Client:Section("Anti Kick")
local MKC=Client:Section("Keybinds")

local FOVC=Visuals:Section("Field Of View")
local CHC=Visuals:Section("Crosshair")
local TTC=Visuals:Section("Target Info")
local RDC=Visuals:Section("Radar")

local UIC=UISettings:Section("Configuration")

local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunServ = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui")
local Space = Instance.new("Frame")
local YAxis = Instance.new("Frame")
local XAxis = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")

local PlaceId = game.PlaceId
local GameId = game.GameId
local LocalPlayer = Players.LocalPlayer
local CharacterAdded
local Camera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
PlayerGui:SetTopbarTransparency(1)
local Mouse = LocalPlayer:GetMouse()
local WindowGUI=game:GetService("CoreGui")[WindowName]
local RawMetatable = getrawmetatable(game)
setreadonly(RawMetatable, false)

if CoreGui:FindFirstChild("Radar") then CoreGui.Radar:Destroy() end
local ScreenGui = Instance.new("ScreenGui")
local Space = Instance.new("Frame")
local YAxis = Instance.new("Frame")
local XAxis = Instance.new("Frame")

ScreenGui.Name = "Radar"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 1000000000
ScreenGui.ResetOnSpawn = false

Space.Name = "Space"
Space.Parent = ScreenGui
Space.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
Space.BorderColor3 = Color3.new(0, 0, 0)
Space.ClipsDescendants = true
Space.Size = UDim2.new(0, 200, 0, 200)
Space.Visible = false

YAxis.Name = "YAxis"
YAxis.Parent = Space
YAxis.BackgroundColor3 = Color3.new(0, 0, 0)
YAxis.BorderSizePixel = 0
YAxis.Position = UDim2.new(0.5, 0, 0, 0)
YAxis.Size = UDim2.new(0, 1, 0, 200)

XAxis.Name = "XAxis"
XAxis.Parent = Space
XAxis.BackgroundColor3 = Color3.new(0, 0, 0)
XAxis.BorderSizePixel = 0
XAxis.Position = UDim2.new(0, 0, 0.5, 0)
XAxis.Size = UDim2.new(0, 200, 0, 1)

getgenv().methodsTable = {"Raycast", "FindPartOnRay", "FindPartOnRayWithIgnoreList", "FindPartOnRayWithWhitelist"}
getgenv().partsTable = {"HumanoidRooPart", "Head", "Torso"}
getgenv().CharacterParent = false
getgenv().AutoDetect = false
getgenv().SelectedTarget = ""
getgenv().VisibiltyCheck = false
getgenv().TeamCheck = false
getgenv().ExemplifyHit = false
getgenv().Distance = 100
getgenv().HitChancePercent = 1
getgenv().HeadShotPercent = 1
getgenv().CircleVisibility = false
getgenv().FOV = 100
getgenv().CrosshairVisibility = false
getgenv().CrosshairThickness = 1
getgenv().CrosshairLength = 6
getgenv().TargetVisibility = false
getgenv().TerrainCheck = false
getgenv().Walls = 1
getgenv().WallSize = 1
getgenv().AutoReload = false
getgenv().TargetYPos = 180
getgenv().AKCRW = 1

warn("Loading Libraries")

local teamLibrary = {
   [1168263273] = function(Target)
       return require(ReplicatedStorage:FindFirstChild("TS")).Teams:GetPlayerTeam(Target)
   end,
   [1581656817] = function(Target)
       if Target == LocalPlayer then
           return tostring(BrickColor.new(0.172549, 0.329412, 1))
       else
           for _, Player in next, Players:GetPlayers() do
               if Player.Character then
                   if Player.Character:FindFirstChild("Head") then
                       if Player.Character == Target.Character then
                           if Player.Character.Head:FindFirstChild("NameTag") then
                               NameTag = Player.Character.Head.NameTag.TextLabel
                               if string.find(tostring(BrickColor.new(NameTag.TextColor3)), "red") then
                                   return tostring(BrickColor.new(NameTag.TextColor3))
                               elseif string.find(tostring(BrickColor.new(NameTag.TextStrokeColor3)), "blue") then
                                   return tostring(BrickColor.new(NameTag.TextStrokeColor3))
                               end
                           end
                       end
                   end
               end
           end
       end
   end,
   [532222553] = function(Target)
       return Target:FindFirstChild("TeamName").Value
   end,
   [1534453623] = function(Target)
       return Target:FindFirstChild("GameStats").Team.Value
   end
}

local charLibrary = {
   [1168263273] = function(Target)
       getgenv().CharacterParent = true
       Character = require(ReplicatedStorage:FindFirstChild("TS")).Characters:GetCharacter(Target)
       if Character and Character:FindFirstChild("Hitbox") and Character.Hitbox:FindFirstChild("Head") then
           return Character:FindFirstChild("Hitbox")
       else
           return nil
       end
   end
}

local hookLibrary = {
   [1760106570] = function() 
       local send;
       for _,v in pairs(getgc(true)) do 
           if typeof(v) == "table" and rawget(v,"send") then
               send = rawget(v,"send")
           end 
       end
       local hook; hook = hookfunction(send, function(self, ...)
           local args = {...} 
           local Target = getgenv().getTarget()
       
           if args[1] == "bullet" and Target and getgenv().getHit(Target) and getgenv().SilentAim then
               local Hit = getgenv().getHit(Target)
               args[2] = Target.Character
               args[3] = Hit
               args[6] = Hit.Position
               return hook(self,unpack(args))
           end 
           return hook(self,unpack(args))
       end)
   end,
   [256843247] = function()
       local hook; hook = hookfunction(workspace.FindPartOnRayWithIgnoreList, function(...)
           local args = {...}
           local Target = getgenv().getTarget()
           local Hit = getgenv().getHit(Target)
           if Hit and getgenv().SilentAim then
               return Hit, Hit.Position, Vector3.new(0, 0, 0), Hit.Material
           end
           return hook(unpack(args))
       end)
   end,
   [1168263273] = function()
       local hook; hook = hookfunction(require(ReplicatedStorage:FindFirstChild("TS")).Network.Fire, function(self, ...)
           local args = {...}
           if args[1] == "Projectiles" and args[2] == "__Hit" then 
               if Hit and getgenv().SilentAim then
                   args[4] = Hit
                   args[5] = Hit.Position
               end
           end 
           return hook(self, unpack(args))
       end)
   end
}

warn("Loading UI Functions")

local function firetoggle1(sectionname, togglename)
   for _, toggle in next, WindowGUI.Drag.Main.Frame.Background.Content:GetDescendants() do
       if toggle:IsA("TextLabel") and toggle.Text == togglename and toggle.Parent.Parent.Title.Text == sectionname then
           for _, connection in next, getconnections(toggle.Parent.MouseButton1Click) do
               connection:Fire()
           end
       end
   end
end

Settings:Toggle("Auto Detect", function(bool)
   getgenv().AutoDetect = bool
end)
Settings:Dropdown("Method", {"FindPartOnRayWithIgnoreList", "Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist"}, function(method)
   getgenv().RayMethodSelected = method
end)
Settings:Dropdown("Target", {"Player", "NPC"}, function(type)
   getgenv().getType = type
   if getgenv().getType == "NPC" then
       getgenv().getNPC()
   else
       getgenv().NPCFolder = nil
   end
end)

SSA:Toggle("Enabled", function(bool)
   getgenv().SilentAim = bool
end)
SSA:Dropdown("Mode", {"Cursor", "Distance"}, function(type)
   getgenv().SelectedMode = type
end)
SSA:Slider("Distance (studs)", 5000, 100, function(value) 
   getgenv().Distance = value
end)
SSA:Slider("Hit Chance (%)", 100, 1, function(value) 
   getgenv().HitChancePercent = value
end)
SSA:Slider("Head Shot Chance (%)", 100, 1, function(value) 
   getgenv().HeadShotPercent = value
end)

Configuration:Toggle("Visibility Check", function(bool)
   getgenv().VisibiltyCheck = bool
end)
Configuration:Toggle("Team Check", function(bool)
   getgenv().TeamCheck = bool
end)
Configuration:Toggle("Health Check", function(bool)
   getgenv().HealthCheck = bool
end)
Configuration:Toggle("ForceField Check", function(bool)
   getgenv().ForceFieldCheck = bool
end)
Configuration:Toggle("Exemplify Hit", function(bool)
   getgenv().ExemplifyHit = bool
end)

KBM:Keybind("Visibilty Check", function()
   firetoggle1("Configuration", "Visibilty Check")
end)
KBM:Keybind("Team Check", function()
   firetoggle1("Configuration", "Team Check")
end)
KBM:Keybind("Aimbot", function()
   firetoggle1("Silent Aim", "Enabled")
end)
KBM:Keybind("Exemplify Hit", function()
   firetoggle1("Configuration", "Exemplify Hit")
end)

FOVC:Toggle("Enabled", function(bool)
   getgenv().CircleVisibility = bool
end)
FOVC:Slider("Radius (px)", (workspace.CurrentCamera.ViewportSize.X / 2), 100, function(value) 
   getgenv().FOV = value
end)
FOVC:Color("Circle Color", Color3.fromRGB(255,0,0), function(color) 
   getgenv().CircleColor = color
end)

CHC:Toggle("Enabled", function(bool)
   getgenv().CrosshairVisibility = bool
end)
CHC:Slider("Thickness (px)", 10, 1, function(value) 
   getgenv().CrosshairThickness = value
end)
CHC:Slider("Length (px)", 15, 6, function(value) 
   getgenv().CrosshairLength = value
end)
CHC:Color("Line Color", Color3.fromRGB(255,0,0), function(color) 
   getgenv().CrosshairColor = color
end)

TTC:Toggle("Enabled", function(bool)
   getgenv().TargetVisibility = bool
end)
TTC:Slider("Y Position (px)", 250, 10, function(value) 
   getgenv().TargetYPos = value
end)
TTC:Color("Text Color", Color3.fromRGB(255,0,0), function(color) 
   getgenv().TargetColor = color
end)

RDC:Toggle("Enabled", function(bool)
   Space.Visible = bool
end)
RDC:Dropdown("Position (px)", {"Top Left", "Top Right", "Bottom Left", "Bottom Right"}, function(position)
   if position == "Top Right" then
       Space.Position = UDim2.new(0.88, 0, 0.02, 0)
   elseif position == "Top Left" then
       Space.Position = UDim2.new(0.02, 0, 0.02, 0)
   elseif position == "Bottom Right" then
       Space.Position = UDim2.new(0.88, 0, 0.777, 0)
   elseif position == "Bottom Left" then
       Space.Position = UDim2.new(0.02, 0, 0.777, 0)
   end
end)
RDC:Slider("Opacity (px)", 9, 0, function(value)
   getgenv().RadarOpacity = value / 10
   Space.BackgroundTransparency = value / 10
   for _, v in next, Space:GetDescendants() do
       v.BackgroundTransparency = value / 10
   end
end)
RDC:Color("Enemy Color", Color3.fromRGB(255,0,0), function(color)
   getgenv().REC = color
end)
RDC:Color("Friendly Color", Color3.fromRGB(0,255,0), function(color)
   getgenv().RFC = color
end)

SMC:Dropdown("Bot Mode", {"None", "Wallbot", "Ragebot", "Rangebot", "Triggerbot"}, function(type)
   getgenv().BotType = type
end)
SMC:Toggle("Terrain Check", function(bool)
   getgenv().TerrainCheck = bool
end)
SMC:Slider("Walls (amount)", 10, 1, function(value)
   getgenv().Walls = value
end)
SMC:Slider("Wall Thickness (studs)", 10, 1, function(value)
   getgenv().WallSize = value
end)

ICC:Dropdown("Click Type", {"Spam", "Hold"}, function(type)
   getgenv().ClickType = type
end)
ICC:Slider("Mouse Release (ns)", 10, 1, function(value) 
   getgenv().CPS = value / 100
end)
ICC:Toggle("Auto Reload", function(bool)
   getgenv().AutoReload = bool
   getgenv().AmmoLabel = nil
   for _, Label in next, LocalPlayer.PlayerGui:GetDescendants() do
       if Label:IsA("TextLabel") then
           if Label.Visible then
               Label:GetPropertyChangedSignal("Text"):Connect(function(text)
                   local Ammo = string.split(Label.Text, "/")
                   if UserInput:IsMouseButtonPressed(0) and tonumber(Ammo[1]) then
                       getgenv().AmmoLabel = Label
                   end
               end)
           end
       end
   end
   while getgenv().AutoReload do
       wait()
       print'test'
       if getgenv().AmmoLabel then
           local Ammo = string.split(getgenv().AmmoLabel.Text, "/")
           if getgenv().AmmoLabel.Visible and tonumber(Ammo[1]) <= getgenv().MinimumAmmo then
               mouse1release()
               keypress(0x52)
               keyrelease(0x52)
           end
       end
   end
end)
ICC:Slider("Minimum Ammo (amount)", 100, 1, function(value) 
   getgenv().MinimumAmmo = value
end)

AKC:Toggle("Auto Rejoin", function(bool)
   getgenv().AKCAR = bool
end)
AKC:Slider("Rejoin Wait (seconds)", 10, 1, function(value)
   getgenv().AKCRW = value
end)
AKC:Dropdown("Rejoin Type", {"Server", "Game"}, function(type)
   if type == "Server" then
       getgenv().RejoinType = game.JobId
   else
       getgenv().RejoinType = nil
   end
end)

MKC:Keybind("Rangebot", function(bool)
   if not bool then
       getgenv().BotType = "None"
   else
       getgenv().BotType = "Rangebot"
   end
end)
MKC:Keybind("Ragebot", function(bool)
   if not bool then
       getgenv().BotType = "None"
   else
       getgenv().BotType = "Ragebot"
   end
end)
MKC:Keybind("Triggerbot", function(bool)
   if not bool then
       getgenv().BotType = "None"
   else
       getgenv().BotType = "Triggerbot"
   end
end)
MKC:Keybind("Wallbot", function(bool)
   if not bool then
       getgenv().BotType = "None"
   else
       getgenv().BotType = "Triggerbot"
   end
end)
MKC:Keybind("Auto Reload", function(bool)
   firetoggle1("Input", "Auto Reload")
end)

UIC:Keybind("UI Visibility", function(bool)
   WindowGUI.Drag.Visible = not bool
end)
UIC:Slider("Opacity (px)", 9, 0, function(value)
   value = value / 10
   WindowGUI.Drag.BackgroundTransparency = value
   WindowMain=WindowGUI.Drag.Main
   WindowMain.BackgroundTransparency = value
   WindowMain.Frame.BackgroundTransparency = value
   WindowMain.Frame.Background.BackgroundTransparency = value

   for _, v in next, WindowMain.Frame.Background.Content:GetDescendants() do
       if not v:IsA("UIListLayout") then
           if v.BackgroundTransparency ~= 1 then
               v.BackgroundTransparency = value
               if string.find(v.ClassName, "Text") then
                   v.TextTransparency = value
               end
           elseif string.find(v.ClassName, "Text") then
               v.TextTransparency = value
           end
       end
   end
   for _, v in next, WindowMain.Frame.Frame:GetChildren() do
       if v:FindFirstChild("Contents") then
           v.TextTransparency =  value
           for _, v in next, v.Contents:GetDescendants() do
               if not v:IsA("UIListLayout") then
                   if v.BackgroundTransparency ~= 1 then
                       v.BackgroundTransparency = value
                       if string.find(v.ClassName, "Text") then
                           v.TextTransparency = value
                       end
                   elseif string.find(v.ClassName, "Text") then
                       v.TextTransparency = value
                   end
               end
           end
       end
   end
   for _,v in next, WindowMain.Heading:GetChildren() do
       if v:IsA("TextLabel") then
           v.TextTransparency =  value
       end
   end
end)

warn("Loading Aimbot Functions")
wait(0.5)

if teamLibrary[GameId] then
   teamType = function(Target)
       if getgenv().TeamCheck then
           return teamLibrary[GameId](Target)
       else
           return true
       end
   end
else
   teamType = function(Target)
       if getgenv().TeamCheck then
           if Target.Team or Target.TeamColor then
               return Target.Team or Target.TeamColor
           end
       else
           return true
       end
   end
end

if charLibrary[GameId] then
   characterType = function(Target)
       return charLibrary[GameId](Target)
   end
else
   characterType = function(Target)
       if Target then
           if Target:IsA("Player") and Target.Character or workspace:FindFirstChild(Target.Name) then
               return Target.Character or workspace:FindFirstChild(Target.Name)
           else
               return Target
           end
       end
   end
end

local function FFA()
   sameTeam = 0
   for _, player in next, Players:GetPlayers() do
       if teamType(player) == teamType(LocalPlayer) then
           sameTeam = sameTeam + 1
       end
   end
   if sameTeam == #Players:GetPlayers() then
       return true
   else
       return false
   end
end

local function returnVisibility(Target)
   if getgenv().VisibiltyCheck then
       if characterType(Target) then 
           local TargetCharacter = characterType(Target)
           if TargetCharacter:FindFirstChild("Head") and characterType(LocalPlayer):FindFirstChild("Head") then 
               local LocalPlayerCharacter = characterType(LocalPlayer)
               if getgenv().CharacterParent then
                   IgnoreList = {LocalPlayerCharacter.Parent, TargetCharacter.Parent}
               else
                   IgnoreList = {LocalPlayerCharacter, TargetCharacter}
               end
               local CastPointParts = Camera:GetPartsObscuringTarget({LocalPlayerCharacter.Head.Position, TargetCharacter.Head.Position}, IgnoreList)
               if unpack(CastPointParts) then
                   return false
               end
           end
       end
   end
   return true
end

local function returnHit(Hit, Args)
   if Hit and getgenv().SilentAim then
       CCF = Camera.CFrame.p
       Args[2] = Ray.new(CCF, (Hit.Position + Vector3.new(0,(CCF-Hit.Position).Magnitude/getgenv().Distance,0) - CCF).unit * (getgenv().Distance * 10))
       return
   end
end

local function returnHealth(Target)
   if getgenv().HealthCheck then
       if characterType(Target) then 
           local TargetCharacter = characterType(Target)
           if TargetCharacter:FindFirstChildOfClass("Humanoid") and TargetCharacter:FindFirstChildOfClass("Humanoid").Health > 0 then
               return true
           else
               return false
           end
       end
   end
   return true
end

local function returnForceField(Target)
   if getgenv().ForceFieldCheck then
       if characterType(Target) and characterType(Target):FindFirstChildOfClass("ForceField") then 
           return false
       end
   end
   return true
end

local function getSurface(Object)
   local position = Vector3.new(0,0,0)
   local surfaces = {
       back = Object.CFrame * CFrame.new(0, 0, Object.Size.Z),
       front = Object.CFrame * CFrame.new(0, 0, -Object.Size.Z),
       right = Object.CFrame * CFrame.new(Object.Size.X, 0, 0),
       left = Object.CFrame * CFrame.new(-Object.Size.X, 0, 0)
   }
   local surface = "back"
   for side, cframe in next, surfaces do
       surface = ((position - cframe.p).magnitude > (position - surfaces[surface].p).magnitude and surface or side)
   end
   if surface == "right" or "left" then
       return Object.Size.X
   elseif surface == "back" or "front" then
       return Object.Size.Z
   end
end

local function getTerrain(Object)
   local MaterialIgnoreList = {"Grass", "Mud", "LeafyGrass", "Ground", "Rock", "Pavement", "Water", "Cobblestone", "Plastic"}
   local NotTerrain = true
   if getgenv().TerrainCheck then
       for _, Material in next, MaterialIgnoreList do
           if string.find(tostring(Object.Material), Material) then
               NotTerrain = false
           end
       end
   end
   return NotTerrain
end

local function getRig(Target)
   selected_RigType = {}
   selected_PartClass = {"Part", "MeshPart"}
   if getgenv().getType == "Player" then
       for _, Player in next,Players:GetPlayers() do
           if characterType(Player) then
               for _, Part in next, characterType(Player):GetChildren() do
                   if table.find(selected_PartClass, Part.ClassName) then
                       table.insert(selected_RigType, Part.Name)
                   end
               end
           end
       end
   elseif getgenv().getType == "NPC" then
       for _, Part in next, Target:GetChildren() do
           if table.find(selected_PartClass, Part.ClassName) then
               table.insert(selected_RigType, Part.Name)
           end
       end
   end
   return selected_RigType
end

getgenv().getHit = function(Target)
   local Hit = nil
   local TargetChar = characterType(Target)
   
   if getgenv().HitToggle then
       if getgenv().HeadShot then
           Hit = TargetChar["Head"]
       else
           PartNum = 0
           RigTable = getRig(Target)
           for _ in next, RigTable do
               PartNum = PartNum + 1
           end
           SelectedMax = math.random(1,PartNum)
           SelectedNum = 0
           for Selected in next, RigTable do
               SelectedNum = SelectedNum + 1
               if SelectedNum == SelectedMax and Selected ~= "Head" and TargetChar[Selected]then
                   Hit = TargetChar[Selected]
               end
           end
       end
   end
   return Hit
end

getgenv().getNPC = function()
   getgenv().NPCFolder = nil
   for _, NPC in next, workspace:GetDescendants() do
       if NPC:IsA("Humanoid") or getgenv().partsTable[NPC.Name] then
           if NPC:FindFirstAncestorOfClass("Model") then
               NPC = NPC:FindFirstAncestorOfClass("Model")
               if not Players:FindFirstChild(NPC.Name) then
                   PlayerCount = 0
                   for _, Player in next, Players:GetPlayers() do
                       if characterType(Player) ~= NPC then
                           PlayerCount = PlayerCount + 1
                       end
                   end
                   Health = true
                   if getgenv().HealthCheck then
                       Health = false
                       for _, Part in next, NPC:GetDescendants() do
                           if Part:IsA("Humanoid") and Part.Health > 0 then
                               Health = true
                           end
                       end
                   end
                   if NPC:FindFirstAncestorOfClass("Folder") and PlayerCount == #Players:GetChildren() and Health then
                       getgenv().NPCFolder = NPC:FindFirstAncestorOfClass("Folder")
                       print(getgenv().NPCFolder)
                       return
                   end
               end
           end
       end
   end
   return getgenv().NPCFolder
end

local Circle = Drawing.new('Circle')
Circle.Transparency = 1
Circle.Thickness = 1.5
Circle.Visible = false
Circle.Color = Color3.fromRGB(255,0,0)
Circle.Filled = false

local TargetText = Drawing.new("Text")
getgenv().SelectedTarget = ""
TargetText.Text = ""
TargetText.Size = 17
TargetText.Center = true
TargetText.Visible = false
TargetText.Color = Color3.fromRGB(255,0,0)
TargetText.Font = Drawing.Fonts.Monospace

local lineX = Drawing.new("Line")
lineX.Transparency = 1
lineX.Thickness = 1.5
lineX.Visible = false
lineX.Color = Color3.fromRGB(255,0,0)

local lineY = Drawing.new("Line")
lineX.Transparency = 1
lineY.Thickness = 1.5
lineY.Visible = false
lineY.Color = Color3.fromRGB(255,0,0)

RunServ:BindToRenderStep("Get_Fov",1,function()
   local Middle = 37
   Circle.Radius = getgenv().FOV
   Circle.Visible = getgenv().CircleVisibility
   TargetText.Visible = getgenv().TargetVisibility
   lineX.Visible = getgenv().CrosshairVisibility
   lineY.Visible = getgenv().CrosshairVisibility 
   Circle.Color = getgenv().CircleColor
   TargetText.Color = getgenv().TargetColor
   lineX.Color = getgenv().CrosshairColor
   lineY.Color = getgenv().CrosshairColor
   lineX.Thickness = getgenv().CrosshairThickness
   lineY.Thickness = getgenv().CrosshairThickness
   Circle.Position = Vector2.new(Mouse.X,Mouse.Y+Middle)
   TargetText.Position = Vector2.new(Mouse.X,Mouse.Y+Middle-getgenv().TargetYPos)
   lineX.From = Vector2.new((Mouse.X)+getgenv().CrosshairLength+1,Mouse.Y-0.5+Middle)
   lineX.To = Vector2.new(Mouse.X-getgenv().CrosshairLength,Mouse.Y-0.5+Middle)
   lineY.From = Vector2.new(Mouse.X,Mouse.Y+getgenv().CrosshairLength+Middle)
   lineY.To = Vector2.new(Mouse.X,Mouse.Y-getgenv().CrosshairLength+Middle)
   TargetText.Text = getgenv().SelectedTarget
end)

spawn(function()
   while wait() do
       if getgenv().SilentAim and getgenv().RegisterClick and getgenv().BotType ~= "None" or not getgenv().SilentAim and getgenv().RegisterClick and getgenv().BotType == "Triggerbot" then
           if getgenv().ClickType == "Hold" then
               mouse1press()
           elseif getgenv().ClickType == "Spam" then
               wait(getgenv().CPS)
               mouse1press()
               wait()
               mouse1release()
           end
       end
   end
end)

RunServ.RenderStepped:Connect(function()
   if (math.random(math.random(0,getgenv().HitChancePercent), 100)) <= getgenv().HitChancePercent then 
        getgenv().HitToggle = true
   else  
       getgenv().HitToggle = false
   end

   if (math.random(math.random(0,getgenv().HeadShotPercent), 100)) <= getgenv().HeadShotPercent then 
       getgenv().HeadShot = true
   else  
       getgenv().HeadShot = false
   end

   if getgenv().AKCAR then
       if not LocalPlayer:FindFirstChild("PlayerScripts") then
           wait(getgenv().AKCRW)
           game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, getgenv().RejoinType, LocalPlayer)
       end
   end

   if getgenv().BotType == "None" or getgenv().BotType == "Rangebot" or getgenv().BotType == "Triggerbot" then
       getgenv().getTarget = function()
           local closestTarg = math.huge
           local Target = nil
           if getgenv().getType == "Player" then
               for _, Player in next, Players:GetPlayers() do
                   if Player ~= LocalPlayer and returnVisibility(Player) and teamType(Player) ~= teamType(LocalPlayer) or FFA() and Player ~= LocalPlayer and returnVisibility(Player) then
                       if characterType(Player) and characterType(LocalPlayer) and characterType(LocalPlayer):FindFirstChild("Head") then
                           local playerCharacter = characterType(Player)
                           local playerPart = playerCharacter:FindFirstChild("Head")
                           if returnHealth(Player) and returnForceField(Player) and playerPart or playerPart then
                               local hitVector, onScreen = Camera:WorldToScreenPoint(playerPart.Position)
                               if onScreen then
                                   local CCF = Camera.CFrame.p
                                   if workspace:FindPartOnRayWithIgnoreList(Ray.new(CCF, (playerPart.Position-CCF).unit * getgenv().Distance),{Player}) then
                                       local distTargMagnitude = (characterType(LocalPlayer):FindFirstChild("Head").Position - playerPart.Position).magnitude
                                       if getgenv().SelectedMode == "Cursor" then
                                           hitTargMagnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(hitVector.X, hitVector.Y)).magnitude
                                       elseif getgenv().SelectedMode == "Distance" then
                                           hitTargMagnitude = distTargMagnitude
                                       end
                                       if hitTargMagnitude < closestTarg and hitTargMagnitude <= getgenv().FOV and distTargMagnitude <= getgenv().Distance then
                                           Target = Player
                                           closestTarg = hitTargMagnitude
                                       end
                                   end
                               end
                           end
                       end
                   end
               end
           elseif getgenv().getType == "NPC" and getgenv().NPCFolder then
               for _, NPC in next, getgenv().NPCFolder:GetChildren() do
                   if returnVisibility(NPC) and returnHealth(NPC) and NPC:FindFirstChildOfClass("Part") and characterType(LocalPlayer) and characterType(LocalPlayer):FindFirstChild("Head") then
                       local hitVector, onScreen = Camera:WorldToScreenPoint(NPC:FindFirstChildOfClass("Part").Position)
                       if onScreen then
                           local CCF = Camera.CFrame.p
                           if workspace:FindPartOnRayWithIgnoreList(Ray.new(CCF, (NPC:FindFirstChildOfClass("Part").Position-CCF).unit * getgenv().Distance),{NPC}) then
                               local distTargMagnitude = (characterType(LocalPlayer):FindFirstChild("Head").Position - NPC:FindFirstChildOfClass("Part").Position).magnitude
                               if getgenv().SelectedMode == "Cursor" then
                                   hitTargMagnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(hitVector.X, hitVector.Y)).magnitude
                               elseif getgenv().SelectedMode == "Distance" then
                                   hitTargMagnitude = distTargMagnitude
                               end
                               if hitTargMagnitude < closestTarg and hitTargMagnitude <= getgenv().FOV and distTargMagnitude <= getgenv().Distance then
                                   Target = NPC
                                   closestTarg = hitTargMagnitude
                               end
                           end
                       end
                   end
               end
           end
           return Target
       end
   elseif getgenv().BotType == "Ragebot" then
       getgenv().getTarget = function()
           local closestTarg = math.huge
           local Target = nil
           if getgenv().getType == "Player" then
               for _, Player in next, Players:GetPlayers() do
               if Player ~= LocalPlayer and returnVisibility(Player) and teamType(Player) ~= teamType(LocalPlayer) or FFA() and Player ~= LocalPlayer and returnVisibility(Player) then
                       if characterType(Player) and characterType(LocalPlayer) and characterType(LocalPlayer):FindFirstChild("Head") then
                           local playerCharacter = characterType(Player)
                           local playerPart = playerCharacter:FindFirstChild("Head")
                           if returnHealth(Player) and returnForceField(Player) and playerPart or playerPart then
                               if getgenv().CharacterParent then
                                   IgnoreList = {characterType(LocalPlayer).Parent, playerCharacter.Parent}
                               else
                                   IgnoreList = {characterType(LocalPlayer), playerCharacter}
                               end
                               local CastPoint = Camera:GetPartsObscuringTarget({characterType(Player).Head.Position, playerPart.Position}, IgnoreList)
                               local distTargMagnitude = (characterType(LocalPlayer):FindFirstChild("Head").Position - playerPart.Position).magnitude
                               if not unpack(CastPoint) and distTargMagnitude <= getgenv().Distance then
                                   if getgenv().SelectedMode == "Cursor" then
                                       Target = Player
                                   elseif getgenv().SelectedMode == "Distance" and distTargMagnitude < closestTarg then
                                       closestTarg = distTargMagnitude
                                       Target = Player
                                   end
                               end 
                           end
                       end
                   end
               end
           elseif getgenv().getType == "NPC" and getgenv().NPCFolder then
               for _, NPC in next, getgenv().NPCFolder:GetChildren() do
                   if returnHealth(NPC) and NPC:FindFirstChildOfClass("Part") and characterType(LocalPlayer) and characterType(LocalPlayer):FindFirstChild("Head") then
                       local CastPoint = Camera:GetPartsObscuringTarget({characterType(LocalPlayer).Head.Position, NPC:FindFirstChildOfClass("Part").Position}, {characterType(LocalPlayer), characterType(NPC)})
                       local distTargMagnitude = (characterType(LocalPlayer):FindFirstChild("Head").Position - NPC:FindFirstChildOfClass("Part").Position).magnitude
                       if not unpack(CastPoint) and distTargMagnitude <= getgenv().Distance then
                           if getgenv().SelectedMode == "Cursor" then
                               Target = NPC
                           elseif getgenv().SelectedMode == "Distance" and distTargMagnitude < closestTarg then
                               closestTarg = distTargMagnitude
                               Target = NPC
                           end
                       end
                   end
               end
           end
           return Target
       end
   elseif getgenv().BotType == "Wallbot" then
       local closestTarg = math.huge
       local Target = nil
       if getgenv().getType == "Player" then
           for _, Player in next, Players:GetPlayers() do
               if Player ~= LocalPlayer and teamType(Player) ~= teamType(LocalPlayer) or FFA() and Player ~= LocalPlayer then
                   if characterType(Player) and characterType(LocalPlayer) and characterType(LocalPlayer):FindFirstChild("Head") then
                       local playerCharacter = characterType(Player)
                       local playerPart = playerCharacter:FindFirstChild("Head")
                       if returnHealth(Player) and returnForceField(Player) and playerPart or playerPart then
                           if getgenv().CharacterParent then
                               IgnoreList = {characterType(LocalPlayer).Parent, playerCharacter.Parent}
                           else
                               IgnoreList = {characterType(LocalPlayer), playerCharacter}
                           end
                           local CastPoint = Camera:GetPartsObscuringTarget({characterType(LocalPlayer).Head.Position, playerPart.Position}, IgnoreList)
                           local distTargMagnitude = (characterType(LocalPlayer):FindFirstChild("Head").Position - playerPart.Position).magnitude
                           if unpack(CastPoint) and #CastPoint <= getgenv().Walls and distTargMagnitude <= getgenv().Distance then
                               for _, Wall in next, CastPoint do
                                   if Wall and Wall.Size then
                                       if getSurface(Wall) <= getgenv().WallSize and getTerrain(Wall) then
                                           if getgenv().SelectedMode == "Cursor" then
                                               Target = Player
                                           elseif getgenv().SelectedMode == "Distance" and distTargMagnitude < closestTarg then
                                               closestTarg = distTargMagnitude
                                               Target = Player
                                           end
                                       end
                                   end
                               end
                           end
                       end
                   end
               end
           end
       elseif getgenv().getType == "NPC" and getgenv().NPCFolder then
           for _, NPC in next, getgenv().NPCFolder:GetChildren() do
               if returnHealth(NPC) and NPC:FindFirstChildOfClass("Part") and characterType(LocalPlayer) and characterType(LocalPlayer):FindFirstChild("Head") then
                   local CastPoint = Camera:GetPartsObscuringTarget({characterType(LocalPlayer).Head.Position, NPC:FindFirstChildOfClass("Part").Position}, {characterType(LocalPlayer), characterType(NPC)})
                   local distTargMagnitude = (characterType(LocalPlayer):FindFirstChild("Head").Position - NPC:FindFirstChildOfClass("Part").Position).magnitude
                   if unpack(CastPoint) and #CastPoint <= getgenv().Walls and distTargMagnitude <= getgenv().Distance then
                       for _, Wall in next, CastPoint do
                           if Wall and Wall.Size then
                               if getSurface(Wall) <= getgenv().WallSize and getTerrain(Wall) then
                                   if getgenv().SelectedMode == "Cursor" then
                                       Target = NPC
                                   elseif getgenv().SelectedMode == "Distance" and distTargMagnitude < closestTarg then
                                       closestTarg = distTargMagnitude
                                       Target = NPC
                                   end
                               end
                           end
                       end
                   end
               end
           end
           return Target
       end
   end

   for _, RadarInt in next, Space:GetChildren() do
       if not string.find(RadarInt.Name, "Axis") then
           RadarInt:Destroy()
       end
   end

   if getgenv().getType == "Player" then
       for _, Player in next, Players:GetPlayers() do
           if Player and Player ~= LocalPlayer and characterType(Player) and characterType(Player):FindFirstChildOfClass("Part") then
               local RadarPlayer = Instance.new("Frame")
               local RadarPlayerPos = Camera.CFrame:ToObjectSpace(characterType(Player):FindFirstChildOfClass("Part").CFrame)
               RadarPlayer.Parent = Space
               RadarPlayer.BackgroundTransparency = getgenv().RadarOpacity
               RadarPlayer.BorderColor3 = Color3.fromRGB(0, 0, 0)
               RadarPlayer.BorderSizePixel = 1
               RadarPlayer.Position = UDim2.new(0, (RadarPlayerPos.X/1.5)+(Space.Size.X.Offset/2.12), 0, (RadarPlayerPos.Z/1.5)+(Space.Size.Y.Offset/2.21)) 
               RadarPlayer.Size = UDim2.new(0, 7, 0, 7)
               if teamType(Player) ~= teamType(LocalPlayer) or FFA() then
                   RadarPlayer.BackgroundColor3 = getgenv().REC
               elseif teamType(Player) == teamType(LocalPlayer) then
                   RadarPlayer.BackgroundColor3 = getgenv().RFC
               end
           end
       end
   elseif getgenv().getType == "NPC" and getgenv().NPCFolder then
       for _, NPC in next, getgenv().NPCFolder:GetChildren() do
           if NPC:FindFirstChildOfClass("Part") then
               local RadarNPC = Instance.new("Frame")
               local RadarNPCPos = Camera.CFrame:ToObjectSpace(NPC:FindFirstChildOfClass("Part").CFrame)
               RadarNPC.Parent = Space
               RadarNPC.BackgroundColor3 = getgenv().REC
               RadarPlayer.BackgroundTransparency = getgenv().RadarOpacity
               RadarNPC.BorderColor3 = Color3.fromRGB(0, 0, 0)
               RadarNPC.BorderSizePixel = 1
               RadarNPC.Position = UDim2.new(0, (RadarNPCPos.X/1.5)+(Space.Size.X.Offset/2.12), 0, (RadarNPCPos.Z/1.5)+(Space.Size.Y.Offset/2.21))
               RadarNPC.Size = UDim2.new(0, 7, 0, 7)
           end
       end
   end
end)

local NameCall = RawMetatable.__namecall

if hookLibrary[GameId] then
   hookLibrary[GameId]()
end

RawMetatable.__namecall = newcclosure(function(...)
   local method = getnamecallmethod()
   local args = {...}
   if getgenv().AutoDetect then
       for _, rayMethod in next, getgenv().methodsTable do
           if method == rayMethod and Hit then
               returnHit(Hit, args)
           end
       end
   else
       if method == getgenv().RayMethodSelected and Hit then
           returnHit(Hit, args)
       end
end
   return NameCall(unpack(args))
end)

warn("Loading Aimbot")
wait(0.5)

RunServ:BindToRenderStep("Get_Target",1,function()
   local Target = getgenv().getTarget()
   if not Target then
       Hit = nil
       getgenv().SelectedTarget = ""
       getgenv().RegisterClick = false
   else
       getgenv().SelectedTarget = Target.Name .. "\n" .. math.floor((characterType(LocalPlayer):FindFirstChildOfClass("Part").Position - characterType(Target):FindFirstChildOfClass("Part").Position).magnitude) .. " Studs"
       if getgenv().ExemplifyHit then
           Hit = getgenv().getHit(Target)
       end
       if getgenv().BotType == "Triggerbot" then
           if Mouse.Target and Mouse.Target:FindFirstAncestorOfClass("Model") == characterType(Target) then
               getgenv().RegisterClick = true
           else
               getgenv().RegisterClick = false
           end
       elseif getgenv().SilentAim then
           getgenv().RegisterClick = true
       end
   end
   if UserInput:IsMouseButtonPressed(0) then
       if Target then
           Hit = getgenv().getHit(Target)
       end
   end
end)

warn("Loaded!")