local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ijoooo/ijoooo/main/ui.lua"))()

local watermark = library:Watermark("Drill V1 | 0.4 | %c")
-- watermark:Set("Watermark Set")
-- watermark:Hide() -- toggles watermark

local main = library:Load{
    Name = "Drill V1",
    SizeX = 500,
    SizeY = 550,
    Theme = "Cyan",
    Extension = "json", -- config file extension
    Folder = "drill.folder" -- config folder name
}

-- library.Extension = "txt" (config file extension)
-- library.Folder = "config folder name"

local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/ijoooo/ijoooo/main/Esp.lua'),true))()
espLib:Load()

local aimbot = loadstring(game:HttpGet'https://raw.githubusercontent.com/ijoooo/ijoooo/main/aimbot.lua')()

local function ItializedMetamethodHooks() 
    local OldIndex = nil
    local OldNameCall = nil
    
    
    OldIndex = hookmetamethod(game, "__index", function(Self, Key) -- METHOD 2
        if checkcaller() then return OldIndex(Self, Key) end 
              
        if library.flags["JumpHack BypassToggle"] and tostring(Key) == "JumpPower" then
            return 50
        end
        if library.flags["SpeedHack BypassToggle"] and tostring(Key) == "WalkSpeed" then
            return 14
        end
        
        return OldIndex(Self, Key)
    end)
end


local Aimbot = main:Tab("Aimbot")

local AimbotSection = Aimbot:Section{
    Name = "Aimbot",
    Side = "Left"
}

local EnableToggleAimbot = AimbotSection:Toggle{
    Name = "Aimbot",
    Flag = "EnableToggleAimbot",
    --Default = true,
    Callback  = function(bool)
        aimbot.Enabled = bool
        aimbot.Players = bool
        aimbot.CustomParts = {Instance.new('Part', workspace)}
    end
}

EnableToggleAimbot:Keybind{
    Default = Enum.KeyCode.E,
    Blacklist = {Enum.UserInputType.MouseButton1},
    Flag = "AimbotToggleKeybind",
    Callback = function(bool)
        aimbot.Key = bool
    end
}

local aimbotSmoothing = AimbotSection:Slider{
    Name = "Smoothing",
    Text = "[value]/5",
    Default = 0,
    Min = 0.2,
    Max = 5,
    Float = 0.2,
    Flag = "aimbotSmoothing",
    Callback = function(value)
        aimbot.Smoothing = value
    end
}

local DrawFOVToggle = AimbotSection:Toggle{
    Name = "Draw FOV",
    Flag = "DrawFOVToggle",
    --Default = true,
    Callback  = function(bool)
        aimbot.ShowFOV = bool
    end
}

local FovColor = DrawFOVToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "FovColor", 
    Callback = function(color)
        aimbot.FOVCircleColor = color
    end
}

local seperator = AimbotSection:Separator("Settings")

local EnableToggleAimbot_TeamCheck = AimbotSection:Toggle{
    Name = "Team Check",
    Flag = "EnableToggleAimbot_TeamCheck",
    --Default = true,
    Callback  = function(bool)
        aimbot.TeamCheck = bool
    end
}

local EnableToggleAliveCheck = AimbotSection:Toggle{
    Name = "Alive Check",
    Flag = "EnableToggleAliveCheck",
    --Default = true,
    Callback  = function(bool)
        aimbot.AliveCheck = bool
    end
}

local Aimbot_FOV_RadiusSlider = AimbotSection:Slider{
    Name = "Fov Radius",
    Text = "[value]/500",
    Default = 200,
    Min = 0,
    Max = 500,
    Float = 1,
    Flag = "chamsOutlineTransparency",
    Callback = function(value)
        aimbot.FOV = value
    end
}

local Visuals = main:Tab("Visuals")

local EspSection = Visuals:Section{
    Name = "Esp",
    Side = "Left"
}

local EnableToggle = EspSection:Toggle{
    Name = "Enable",
    Flag = "EnableToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.enabled = bool
    end
}

local BoxToggle = EspSection:Toggle{
    Name = "Box",
    Flag = "BoxToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.boxes = bool
    end
}

local boxColor = BoxToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "boxColor", 
    Callback = function(color)
        espLib.options.boxesColor = color
    end
}

local boxFillToggle = EspSection:Toggle{
    Name = "BoxFill",
    Flag = "boxFillToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.boxFill = bool
    end
}

local boxColor = boxFillToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "BoxFill", 
    Callback = function(color)
        espLib.options.boxFillColor = color
    end
}

local healthBarsToggle = EspSection:Toggle{
    Name = "HealthBars",
    Flag = "healthBarsToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.healthBars = bool
    end
}

local healthBarsColor = healthBarsToggle:ColorPicker{
    Default = Color3.fromRGB(0, 255, 0), 
    Flag = "boxColor", 
    Callback = function(color)
        espLib.options.healthBarsColor = color
    end
}

local tracerstoggle = EspSection:Toggle{
    Name = "Tracers",
    Flag = "tracerstoggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.tracers  = bool
    end
}

local tracerColor = tracerstoggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "tracerColor", 
    Callback = function(color)
        espLib.options.tracerColor = color
    end
}

local ChamsToggle = EspSection:Toggle{
    Name = "Chams",
    Flag = "ChamsToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.chams  = bool
    end
}

local chamsFillColor = ChamsToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "chamsFillColor", 
    Callback = function(color)
        espLib.options.chamsFillColor = color
    end
}

local chamsOutlineColor = ChamsToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "chamsOutline", 
    Callback = function(color)
        espLib.options.chamsOutlineColor = color
    end
}

local OOVToggle = EspSection:Toggle{
    Name = "OOV Arrow",
    Flag = "OOVToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.outOfViewArrows = bool
        espLib.options.outOfViewArrowsOutline = bool
    end
}

local OOVColor1 = OOVToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "outOfViewArrowsColor", 
    Callback = function(color)
        espLib.options.outOfViewArrowsColor = color
    end
}

local OOVColor2 = OOVToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "outOfViewArrowsOutlineColor", 
    Callback = function(color)
        espLib.options.outOfViewArrowsOutlineColor = color
    end
}

local seperator = EspSection:Separator("Info")

local nameToggle = EspSection:Toggle{
    Name = "Names",
    Flag = "namesToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.names = bool
    end
}

local nameColor = nameToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "NamesColor", 
    Callback = function(color)
        espLib.options.nameColor = color
    end
}

local distanceToggle = EspSection:Toggle{
    Name = "Distance",
    Flag = "DistanceToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.distance = bool
    end
}

local distanceColor = distanceToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "distanceColor", 
    Callback = function(color)
        espLib.options.distanceColor = color
    end
}

local healthTextToggle = EspSection:Toggle{
    Name = "HealthText",
    Flag = "healthTextToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.healthText = bool
    end
}

local healthTextColor = healthTextToggle:ColorPicker{
    Default = Color3.fromRGB(0, 255, 0), 
    Flag = "healthTextColor", 
    Callback = function(color)
        espLib.options.healthTextColor = color
    end
}

local EspSettingsSection = Visuals:Section{
    Name = "Settings",
    Side = "Right"
}

local TeamCheckToggle = EspSettingsSection:Toggle{
    Name = "Team Check",
    Flag = "TeamCheck",
    --Default = true,
    Callback  = function(bool)
        espLib.options.teamCheck = bool
    end
}

local visibleOnlyToggle = EspSettingsSection:Toggle{
    Name = "Visible Only",
    Flag = "visibleOnlyToggle",
    --Default = true,
    Callback  = function(bool)
        espLib.options.visibleOnly = bool
    end
}

local BoxFillTransparencySlider = EspSettingsSection:Slider{
    Name = "BoxFill Transparency",
    Text = "[value]/1",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Float = 0.1,
    Flag = "BoxFill Transparency Slider",
    Callback = function(value)
        espLib.options.boxFillTransparency = value
    end
}

local TeamCheckToggle = EspSettingsSection:Toggle{
    Name = "Limit Distance",
    Flag = "limitDistance",
    --Default = true,
    Callback  = function(bool)
        espLib.options.limitDistance = bool
    end
}

local MaxDistanceSlider = EspSettingsSection:Slider{
    Name = "Max Distance",
    Text = "[value]/Studs",
    Default = 500,
    Min = 100,
    Max = 1000,
    Float = 1,
    Flag = "MaxDistanceSlider",
    Callback = function(value)
        espLib.options.maxDistance = value
    end
}

local FontSizeSlider = EspSettingsSection:Slider{
    Name = "Font",
    Text = "[value]",
    Default = 2,
    Min = 0,
    Max = 4,
    Float = 1,
    Flag = "FontSlider",
    Callback = function(value)
        espLib.options.font = value
    end
}

local FontSizeSlider = EspSettingsSection:Slider{
    Name = "Font Size",
    Text = "[value]/15",
    Default = 13,
    Min = 10,
    Max = 15,
    Float = 1,
    Flag = "FontSizeSlider",
    Callback = function(value)
        espLib.options.fontSize = value
    end
}

local TracerOriginDrop = EspSettingsSection:Dropdown{
    Name = "Tracer Origin",
    Default = "Bottom",
    Content = {
        "Mouse",
        "Top",
        "Bottom"
    },
    Flag = "TracerOriginDrop",
    Callback = function(option)
        espLib.options.tracerOrigin = option
    end
}

local FontSizeSlider = EspSettingsSection:Slider{
    Name = "ChamsFill Transparency",
    Text = "[value]/1",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Float = 0.1,
    Flag = "chamsFillTransparency",
    Callback = function(value)
        espLib.options.chamsFillTransparency = value
    end
}

local FontSizeSlider = EspSettingsSection:Slider{
    Name = "ChamsOutline Transparency",
    Text = "[value]/1",
    Default = 0,
    Min = 0,
    Max = 1,
    Float = 0.1,
    Flag = "chamsOutlineTransparency",
    Callback = function(value)
        espLib.options.chamsOutlineTransparency = value
    end
}

local seperator = EspSettingsSection:Separator("OOV Settings")

local FontSizeSlider = EspSettingsSection:Slider{
    Name = "OOV Arrow size",
    Text = "[value]",
    Default = 10,
    Min = 5,
    Max = 25,
    Float = 1,
    Flag = "outOfViewArrowsSize",
    Callback = function(value)
        espLib.options.outOfViewArrowsSize = value
    end
}

local outOfViewArrowsRadius = EspSettingsSection:Slider{
    Name = "OOV Arrow radius",
    Text = "[value]/200",
    Default = 30,
    Min = 0,
    Max = 200,
    Float = 1,
    Flag = "outOfViewArrowsSize",
    Callback = function(value)
        espLib.options.outOfViewArrowsRadius = value
    end
}

local WorldSection = Visuals:Section{
    Name = "World",
    Side = "Left"
}

local AmbientToggle = WorldSection:Toggle{
    Name = "Ambient",
    Flag = "AmbientToggle",
    --Default = true,
}

local AmbientColor = AmbientToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "AmbientColor", 
    Callback = function(color)
        if library.flags["AmbientToggle"] then
            game:GetService("Lighting").Ambient = color
        end
    end
}

local OutdoorAmbientColor = AmbientToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "OutdoorAmbientColor", 
    Callback = function(color)
        if library.flags["AmbientToggle"] then
            game:GetService("Lighting").OutdoorAmbient = color
        end
    end
}

local ColorShiftToggle = WorldSection:Toggle{
    Name = "ColorShift",
    Flag = "ColorShiftToggle",
    --Default = true,
}

local ColorShift_Top = ColorShiftToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "ColorShift_Top", 
    Callback = function(color)
        if library.flags["ColorShiftToggle"] then
            game:GetService("Lighting").ColorShift_Top = color
        end
    end
}

local ColorShift_Bottom = ColorShiftToggle:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "ColorShift_Bottom", 
    Callback = function(color)
        if library.flags["ColorShiftToggle"] then
            game:GetService("Lighting").ColorShift_Bottom  = color
        end
    end
}

local TimeChangerToggle = WorldSection:Toggle{
    Name = "Time Changer",
    Flag = "TimeChangerToggle",
    --Default = true,
}

TimeChangerToggle:Slider{
    Text = "[value] Hours",
    --Default = 5,
    Min = 0,
    Max = 24,
    Float = 1,
    Flag = "TimeChangerSlider",
    Callback = function(change)
        if library.flags["TimeChangerToggle"] then
            game:GetService("Lighting").ClockTime = change
        end
    end
}

local Misc = main:Tab("Misc")

local MovementSection = Misc:Section{
    Name = "Movement",
    Side = "Left"
}

local SpeedHackToggle = MovementSection:Toggle{
    Name = "SpeedHack",
    Flag = "SpeedHackToggle",
    --Default = true,
    Callback = function(state)
        if not state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
}

SpeedHackToggle:Slider{
    Text = "[value]/30",
    --Default = 5,
    Min = 0,
    Max = 30,
    Float = 1,
    Flag = "SpeedhackSlider",
    Callback = function(change)
        if library.flags["SpeedHackToggle"] then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = change
        end
    end
}

local JumpHackToggle = MovementSection:Toggle{
    Name = "JumpHack",
    Flag = "JumpHackToggle",
    --Default = true,
    Callback = function(state)
        if not state then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
}

JumpHackToggle:Slider{
    Text = "[value]/0",
    --Default = 5,
    Min = 0,
    Max = 70,
    Float = 1,
    Flag = "JumphackSlider",
    Callback = function(change)
        if library.flags["JumpHackToggle"] then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = change
        end
    end
}

local SpeedHack BypassToggle = MovementSection:Toggle{
    Name = "SpeedHack Bypass",
    Flag = "SpeedHack BypassToggle",
    --Default = true,
    Callback = function()
        if not HasInitialized then ItializedMetamethodHooks() end HasInitialized = true
    end
}

local JumpHack BypassToggle = MovementSection:Toggle{
    Name = "JumpHack Bypass",
    Flag = "JumpHack BypassToggle",
    --Default = true,
    Callback = function()
        if not HasInitialized then ItializedMetamethodHooks() end HasInitialized = true
    end
}

local configs = main:Tab("Configuration")

local keybindsection = configs:Section{Name = "UI", Side = "Left"}

keybindsection:Keybind{
    Name = "UI Open / Close",
    Flag = "UI Toggle",
    Default = Enum.KeyCode.RightShift,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Close()
        end
    end
}

keybindsection:Button{
    Name = "Unload",
    Callback  = function()
        library:Unload()
    end
}

local themes = configs:Section{Name = "Theme", Side = "Right"}

local themepickers = {}

local themelist = themes:Dropdown{
    Name = "Theme",
    Default = library.currenttheme,
    Content = library:GetThemes(),
    Flag = "Theme Dropdown",
    Callback = function(option)
        if option then
            library:SetTheme(option)

            for option, picker in next, themepickers do
                picker:Set(library.theme[option])
            end
        end
    end
}

library:ConfigIgnore("Theme Dropdown")

local namebox = themes:Box{
    Name = "Custom Theme Name",
    Placeholder = "Custom Theme",
    Flag = "Custom Theme"
}

library:ConfigIgnore("Custom Theme")

themes:Button{
    Name = "Save Custom Theme",
    Callback = function()
        if library:SaveCustomTheme(library.flags["Custom Theme"]) then
            themelist:Refresh(library:GetThemes())
            themelist:Set(library.flags["Custom Theme"])
            namebox:Set("")
        end
    end
}

local customtheme = configs:Section{Name = "Custom Theme", Side = "Right"}

themepickers["Accent"] = customtheme:ColorPicker{
    Name = "Accent",
    Default = library.theme["Accent"],
    Flag = "Accent",
    Callback = function(color)
        library:ChangeThemeOption("Accent", color)
    end
}

library:ConfigIgnore("Accent")

themepickers["Window Background"] = customtheme:ColorPicker{
    Name = "Window Background",
    Default = library.theme["Window Background"],
    Flag = "Window Background",
    Callback = function(color)
        library:ChangeThemeOption("Window Background", color)
    end
}

library:ConfigIgnore("Window Background")

themepickers["Window Border"] = customtheme:ColorPicker{
    Name = "Window Border",
    Default = library.theme["Window Border"],
    Flag = "Window Border",
    Callback = function(color)
        library:ChangeThemeOption("Window Border", color)
    end
}

library:ConfigIgnore("Window Border")

themepickers["Tab Background"] = customtheme:ColorPicker{
    Name = "Tab Background",
    Default = library.theme["Tab Background"],
    Flag = "Tab Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Background", color)
    end
}

library:ConfigIgnore("Tab Background")

themepickers["Tab Border"] = customtheme:ColorPicker{
    Name = "Tab Border",
    Default = library.theme["Tab Border"],
    Flag = "Tab Border",
    Callback = function(color)
        library:ChangeThemeOption("Tab Border", color)
    end
}

library:ConfigIgnore("Tab Border")

themepickers["Tab Toggle Background"] = customtheme:ColorPicker{
    Name = "Tab Toggle Background",
    Default = library.theme["Tab Toggle Background"],
    Flag = "Tab Toggle Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Toggle Background", color)
    end
}

library:ConfigIgnore("Tab Toggle Background")

themepickers["Section Background"] = customtheme:ColorPicker{
    Name = "Section Background",
    Default = library.theme["Section Background"],
    Flag = "Section Background",
    Callback = function(color)
        library:ChangeThemeOption("Section Background", color)
    end
}

library:ConfigIgnore("Section Background")

themepickers["Section Border"] = customtheme:ColorPicker{
    Name = "Section Border",
    Default = library.theme["Section Border"],
    Flag = "Section Border",
    Callback = function(color)
        library:ChangeThemeOption("Section Border", color)
    end
}

library:ConfigIgnore("Section Border")

themepickers["Text"] = customtheme:ColorPicker{
    Name = "Text",
    Default = library.theme["Text"],
    Flag = "Text",
    Callback = function(color)
        library:ChangeThemeOption("Text", color)
    end
}

library:ConfigIgnore("Text")

themepickers["Disabled Text"] = customtheme:ColorPicker{
    Name = "Disabled Text",
    Default = library.theme["Disabled Text"],
    Flag = "Disabled Text",
    Callback = function(color)
        library:ChangeThemeOption("Disabled Text", color)
    end
}

library:ConfigIgnore("Disabled Text")

themepickers["Object Background"] = customtheme:ColorPicker{
    Name = "Object Background",
    Default = library.theme["Object Background"],
    Flag = "Object Background",
    Callback = function(color)
        library:ChangeThemeOption("Object Background", color)
    end
}

library:ConfigIgnore("Object Background")

themepickers["Object Border"] = customtheme:ColorPicker{
    Name = "Object Border",
    Default = library.theme["Object Border"],
    Flag = "Object Border",
    Callback = function(color)
        library:ChangeThemeOption("Object Border", color)
    end
}

library:ConfigIgnore("Object Border")

themepickers["Dropdown Option Background"] = customtheme:ColorPicker{
    Name = "Dropdown Option Background",
    Default = library.theme["Dropdown Option Background"],
    Flag = "Dropdown Option Background",
    Callback = function(color)
        library:ChangeThemeOption("Dropdown Option Background", color)
    end
}

library:ConfigIgnore("Dropdown Option Background")

local configsection = configs:Section{Name = "Configs", Side = "Left"}

local configlist = configsection:Dropdown{
    Name = "Configs",
    Content = library:GetConfigs(), -- GetConfigs(true) if you want universal configs
    Flag = "Config Dropdown"
}

library:ConfigIgnore("Config Dropdown")

local loadconfig = configsection:Button{
    Name = "Load Config",
    Callback = function()
        library:LoadConfig(library.flags["Config Dropdown"]) -- LoadConfig(library.flags["Config Dropdown"], true)  if you want universal configs
    end
}

local delconfig = configsection:Button{
    Name = "Delete Config",
    Callback = function()
        library:DeleteConfig(library.flags["Config Dropdown"]) -- DeleteConfig(library.flags["Config Dropdown"], true)  if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}


local configbox = configsection:Box{
    Name = "Config Name",
    Placeholder = "Config Name",
    Flag = "Config Name"
}

library:ConfigIgnore("Config Name")

local save = configsection:Button{
    Name = "Save Config",
    Callback = function()
        library:SaveConfig(library.flags["Config Dropdown"] or library.flags["Config Name"]) -- SaveConfig(library.flags["Config Name"], true) if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}
