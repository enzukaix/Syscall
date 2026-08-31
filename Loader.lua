--[[
  _________                          .__  .__   
 /   _____/__.__. ______ ____ _____  |  | |  |  
 \_____  <   |  |/  ___// ___\\__  \ |  | |  |  
 /        \___  |\___ \\  \___ / __ \|  |_|  |__
/_______  / ____/____  >\___  >____  /____/____/
        \/\/         \/     \/     \/           
        
        Version: v1.1.2
        Author: EnzukaiX team
        discord: https://dsc.gg/syscallx
  ________               _____                            __                
 /  _____/  ____   _____/ ____\__.__. ______ ____ _____ _/  |_  ___________ 
/   \  ___ /  _ \ /  _ \   __<   |  |/  ___// ___\\__  \\   __\/  _ \_  __ \
\    \_\  (  <_> |  <_> )  |  \___  |\___ \\  \___ / __ \|  | (  <_> )  | \/
 \______  /\____/ \____/|__|  / ____/____  >\___  >____  /__|  \____/|__|   
        \/                    \/         \/     \/     \/                           
           Author: 1xayd1
           Discord: https://discord.gg/wAzBtmU7Mb
]]           

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

for _, child in ipairs(CoreGui:GetChildren()) do
    if child.Name:sub(1, 11) == "SYS-LOADER_" then
        child:Destroy()
    end
end

local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "New"
Junkie.identifier = "6881"
Junkie.provider = "Syscall"

local KEY_FILE = "syscall_key.txt"

local function saveKey(key)
    if writefile then
        pcall(function()
            writefile(KEY_FILE, key)
        end)
    end
end

local function loadSavedKey()
    if isfile and readfile and isfile(KEY_FILE) then
        local ok, data = pcall(readfile, KEY_FILE)
        if ok and data and #data > 0 then
            return data
        end
    end
    return nil
end

local function GenerateRandomId()
    local id = ""
    for i = 1, 10 do
        id = id .. tostring(math.random(0, 9))
    end
    return id
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SYS-LOADER_" .. GenerateRandomId()
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = CoreGui

local ToggleIcon = Instance.new("TextButton")
ToggleIcon.Name = "ToggleIcon"
ToggleIcon.Size = UDim2.new(0, 36, 0, 36)
ToggleIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
ToggleIcon.BorderSizePixel = 0
ToggleIcon.Text = "S"
ToggleIcon.TextColor3 = Color3.fromRGB(242, 133, 0)
ToggleIcon.TextSize = 18
ToggleIcon.Font = Enum.Font.Code
ToggleIcon.Active = true
ToggleIcon.Draggable = true
ToggleIcon.Parent = ScreenGui

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(50, 55, 65)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleIcon

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleIcon

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 460, 0, 310)
Main.Position = UDim2.new(0.5, -230, 0.5, -155)
Main.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local OuterBorder = Instance.new("UIStroke")
OuterBorder.Color = Color3.fromRGB(50, 55, 65)
OuterBorder.Thickness = 1.5
OuterBorder.Parent = Main

local AccentBar = Instance.new("Frame")
AccentBar.Name = "AccentBar"
AccentBar.Size = UDim2.new(1, 0, 0, 2)
AccentBar.Position = UDim2.new(0, 0, 0, 0)
AccentBar.BackgroundColor3 = Color3.fromRGB(242, 133, 0)
AccentBar.BorderSizePixel = 0
AccentBar.Parent = Main

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.Position = UDim2.new(0, 0, 0, 2)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 17, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -12, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Syscall Loader"
TitleLabel.TextColor3 = Color3.fromRGB(200, 205, 215)
TitleLabel.TextSize = 12
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local iconDragStart, iconWasDragged
ToggleIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        iconDragStart = input.Position
        iconWasDragged = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and iconDragStart then
        if (input.Position - iconDragStart).Magnitude > 5 then
            iconWasDragged = true
        end
    end
end)

ToggleIcon.MouseButton1Click:Connect(function()
    if not iconWasDragged then
        Main.Visible = not Main.Visible
    end
end)

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -78)
Content.Position = UDim2.new(0, 10, 0, 36)
Content.BackgroundTransparency = 1
Content.Parent = Main

local GamesFrame = Instance.new("Frame")
GamesFrame.Name = "GamesFrame"
GamesFrame.Size = UDim2.new(0.5, -5, 1, 0)
GamesFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 19)
GamesFrame.BorderSizePixel = 0
GamesFrame.Parent = Content

local GamesStroke = Instance.new("UIStroke")
GamesStroke.Color = Color3.fromRGB(35, 38, 45)
GamesStroke.Thickness = 1
GamesStroke.Parent = GamesFrame

local GamesHeader = Instance.new("TextLabel")
GamesHeader.Size = UDim2.new(1, 0, 0, 22)
GamesHeader.BackgroundColor3 = Color3.fromRGB(25, 27, 32)
GamesHeader.BorderSizePixel = 0
GamesHeader.Text = "  Games"
GamesHeader.TextColor3 = Color3.fromRGB(242, 133, 0)
GamesHeader.TextSize = 11
GamesHeader.Font = Enum.Font.Code
GamesHeader.TextXAlignment = Enum.TextXAlignment.Left
GamesHeader.Parent = GamesFrame

local GamesScroll = Instance.new("ScrollingFrame")
GamesScroll.Size = UDim2.new(1, -6, 1, -26)
GamesScroll.Position = UDim2.new(0, 3, 0, 24)
GamesScroll.BackgroundTransparency = 1
GamesScroll.BorderSizePixel = 0
GamesScroll.ScrollBarThickness = 3
GamesScroll.ScrollBarImageColor3 = Color3.fromRGB(242, 133, 0)
GamesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
GamesScroll.Parent = GamesFrame

local GamesLayout = Instance.new("UIListLayout")
GamesLayout.SortOrder = Enum.SortOrder.LayoutOrder
GamesLayout.Padding = UDim.new(0, 2)
GamesLayout.Parent = GamesScroll

local ScriptsFrame = Instance.new("Frame")
ScriptsFrame.Name = "ScriptsFrame"
ScriptsFrame.Size = UDim2.new(0.5, -5, 1, 0)
ScriptsFrame.Position = UDim2.new(0.5, 5, 0, 0)
ScriptsFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 19)
ScriptsFrame.BorderSizePixel = 0
ScriptsFrame.Parent = Content

local ScriptsStroke = Instance.new("UIStroke")
ScriptsStroke.Color = Color3.fromRGB(35, 38, 45)
ScriptsStroke.Thickness = 1
ScriptsStroke.Parent = ScriptsFrame

local ScriptsHeader = Instance.new("TextLabel")
ScriptsHeader.Size = UDim2.new(1, 0, 0, 22)
ScriptsHeader.BackgroundColor3 = Color3.fromRGB(25, 27, 32)
ScriptsHeader.BorderSizePixel = 0
ScriptsHeader.Text = "  Scripts"
ScriptsHeader.TextColor3 = Color3.fromRGB(242, 133, 0)
ScriptsHeader.TextSize = 11
ScriptsHeader.Font = Enum.Font.Code
ScriptsHeader.TextXAlignment = Enum.TextXAlignment.Left
ScriptsHeader.Parent = ScriptsFrame

local ScriptsScroll = Instance.new("ScrollingFrame")
ScriptsScroll.Size = UDim2.new(1, -6, 1, -26)
ScriptsScroll.Position = UDim2.new(0, 3, 0, 24)
ScriptsScroll.BackgroundTransparency = 1
ScriptsScroll.BorderSizePixel = 0
ScriptsScroll.ScrollBarThickness = 3
ScriptsScroll.ScrollBarImageColor3 = Color3.fromRGB(242, 133, 0)
ScriptsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsScroll.Parent = ScriptsFrame

local ScriptsLayout = Instance.new("UIListLayout")
ScriptsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptsLayout.Padding = UDim.new(0, 2)
ScriptsLayout.Parent = ScriptsScroll

local BottomFrame = Instance.new("Frame")
BottomFrame.Name = "BottomFrame"
BottomFrame.Size = UDim2.new(1, -20, 0, 28)
BottomFrame.Position = UDim2.new(0, 10, 1, -34)
BottomFrame.BackgroundTransparency = 1
BottomFrame.Parent = Main

local LoadBtn = Instance.new("TextButton")
LoadBtn.Size = UDim2.new(0.7, -4, 1, 0)
LoadBtn.Position = UDim2.new(0, 0, 0, 0)
LoadBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 40)
LoadBtn.BorderSizePixel = 0
LoadBtn.Text = "Load Script"
LoadBtn.TextColor3 = Color3.fromRGB(242, 133, 0)
LoadBtn.TextSize = 11
LoadBtn.Font = Enum.Font.Code
LoadBtn.Parent = BottomFrame

local LoadBtnStroke = Instance.new("UIStroke")
LoadBtnStroke.Color = Color3.fromRGB(242, 133, 0)
LoadBtnStroke.Thickness = 1
LoadBtnStroke.Parent = LoadBtn

local UnloadBtn = Instance.new("TextButton")
UnloadBtn.Size = UDim2.new(0.3, 0, 1, 0)
UnloadBtn.Position = UDim2.new(0.7, 4, 0, 0)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 20)
UnloadBtn.BorderSizePixel = 0
UnloadBtn.Text = "Unload"
UnloadBtn.TextColor3 = Color3.fromRGB(220, 70, 70)
UnloadBtn.TextSize = 11
UnloadBtn.Font = Enum.Font.Code
UnloadBtn.Parent = BottomFrame

local UnloadBtnStroke = Instance.new("UIStroke")
UnloadBtnStroke.Color = Color3.fromRGB(150, 40, 40)
UnloadBtnStroke.Thickness = 1
UnloadBtnStroke.Parent = UnloadBtn

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 460, 0, 310)
KeyFrame.Position = UDim2.new(0.5, -230, 0.5, -155)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyOuterBorder = Instance.new("UIStroke")
KeyOuterBorder.Color = Color3.fromRGB(50, 55, 65)
KeyOuterBorder.Thickness = 1.5
KeyOuterBorder.Parent = KeyFrame

local KeyAccentBar = Instance.new("Frame")
KeyAccentBar.Size = UDim2.new(1, 0, 0, 2)
KeyAccentBar.BackgroundColor3 = Color3.fromRGB(242, 133, 0)
KeyAccentBar.BorderSizePixel = 0
KeyAccentBar.Parent = KeyFrame

local KeyTitleBar = Instance.new("Frame")
KeyTitleBar.Size = UDim2.new(1, 0, 0, 28)
KeyTitleBar.Position = UDim2.new(0, 0, 0, 2)
KeyTitleBar.BackgroundColor3 = Color3.fromRGB(15, 17, 20)
KeyTitleBar.BorderSizePixel = 0
KeyTitleBar.Parent = KeyFrame

local KeyTitleLabel = Instance.new("TextLabel")
KeyTitleLabel.Size = UDim2.new(1, -12, 1, 0)
KeyTitleLabel.Position = UDim2.new(0, 10, 0, 0)
KeyTitleLabel.BackgroundTransparency = 1
KeyTitleLabel.Text = "Syscall Loader - Key System"
KeyTitleLabel.TextColor3 = Color3.fromRGB(200, 205, 215)
KeyTitleLabel.TextSize = 12
KeyTitleLabel.Font = Enum.Font.Code
KeyTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyTitleLabel.Parent = KeyTitleBar

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 32)
KeyBox.Position = UDim2.new(0, 20, 0, 60)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 16, 19)
KeyBox.BorderSizePixel = 0
KeyBox.Text = ""
KeyBox.PlaceholderText = "Enter your key..."
KeyBox.TextColor3 = Color3.fromRGB(200, 205, 215)
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 105, 115)
KeyBox.TextSize = 12
KeyBox.Font = Enum.Font.Code
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Color = Color3.fromRGB(35, 38, 45)
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Parent = KeyBox

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 4)
KeyBoxCorner.Parent = KeyBox

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -25, 0, 32)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 110)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 40)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(242, 133, 0)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.Code
GetKeyBtn.Parent = KeyFrame

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Color = Color3.fromRGB(242, 133, 0)
GetKeyStroke.Thickness = 1
GetKeyStroke.Parent = GetKeyBtn

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 4)
GetKeyCorner.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0.5, -25, 0, 32)
CheckKeyBtn.Position = UDim2.new(0.5, 5, 0, 110)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 40)
CheckKeyBtn.BorderSizePixel = 0
CheckKeyBtn.Text = "Check Key"
CheckKeyBtn.TextColor3 = Color3.fromRGB(242, 133, 0)
CheckKeyBtn.TextSize = 12
CheckKeyBtn.Font = Enum.Font.Code
CheckKeyBtn.Parent = KeyFrame

local CheckKeyStroke = Instance.new("UIStroke")
CheckKeyStroke.Color = Color3.fromRGB(242, 133, 0)
CheckKeyStroke.Thickness = 1
CheckKeyStroke.Parent = CheckKeyBtn

local CheckKeyCorner = Instance.new("UICorner")
CheckKeyCorner.CornerRadius = UDim.new(0, 4)
CheckKeyCorner.Parent = CheckKeyBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 40)
StatusLabel.Position = UDim2.new(0, 20, 0, 160)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(160, 165, 175)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextWrapped = true
StatusLabel.Parent = KeyFrame

local GameListURL = "https://syscall-gamelist.lovable.app/API/gamelist.lua"
local FetchedData = {}
local SelectedGameName = nil
local SelectedScriptData = nil
local LastRefresh = 0

local SelectedGameBtn = nil
local SelectedScriptBtn = nil

local function ClearScroll(scroll)
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
end

local function RenderScripts(gameName)
    ClearScroll(ScriptsScroll)
    SelectedScriptData = nil
    SelectedScriptBtn = nil
    
    if not gameName or not FetchedData[gameName] then return end
    
    local scripts = FetchedData[gameName]
    for _, scriptObj in ipairs(scripts) do
        if scriptObj.name then
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 22)
            Btn.BackgroundColor3 = Color3.fromRGB(22, 25, 30)
            Btn.BorderSizePixel = 0
            Btn.Text = "  " .. scriptObj.name
            Btn.TextColor3 = Color3.fromRGB(160, 165, 175)
            Btn.TextSize = 11
            Btn.Font = Enum.Font.Code
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.Parent = ScriptsScroll
            
            Btn.MouseButton1Click:Connect(function()
                if SelectedScriptBtn then
                    SelectedScriptBtn.BackgroundColor3 = Color3.fromRGB(22, 25, 30)
                    SelectedScriptBtn.TextColor3 = Color3.fromRGB(160, 165, 175)
                end
                SelectedScriptBtn = Btn
                SelectedScriptData = scriptObj
                Btn.BackgroundColor3 = Color3.fromRGB(242, 133, 0)
                Btn.TextColor3 = Color3.fromRGB(10, 10, 10)
            end)
        end
    end
    
    ScriptsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScriptsScroll.CanvasSize = UDim2.new(0, 0, 0, ScriptsLayout.AbsoluteContentSize.Y)
    end)
end

local function RenderGames()
    ClearScroll(GamesScroll)
    
    local gameNames = {}
    for name in pairs(FetchedData) do
        table.insert(gameNames, name)
    end
    table.sort(gameNames)
    
    for _, name in ipairs(gameNames) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 22)
        Btn.BackgroundColor3 = Color3.fromRGB(22, 25, 30)
        Btn.BorderSizePixel = 0
        Btn.Text = "  " .. name
        Btn.TextColor3 = Color3.fromRGB(160, 165, 175)
        Btn.TextSize = 11
        Btn.Font = Enum.Font.Code
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.Parent = GamesScroll
        
        if SelectedGameName == name then
            SelectedGameBtn = Btn
            Btn.BackgroundColor3 = Color3.fromRGB(242, 133, 0)
            Btn.TextColor3 = Color3.fromRGB(10, 10, 10)
        end
        
        Btn.MouseButton1Click:Connect(function()
            if SelectedGameBtn then
                SelectedGameBtn.BackgroundColor3 = Color3.fromRGB(22, 25, 30)
                SelectedGameBtn.TextColor3 = Color3.fromRGB(160, 165, 175)
            end
            SelectedGameBtn = Btn
            SelectedGameName = name
            Btn.BackgroundColor3 = Color3.fromRGB(242, 133, 0)
            Btn.TextColor3 = Color3.fromRGB(10, 10, 10)
            
            RenderScripts(name)
        end)
    end
    
    GamesLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        GamesScroll.CanvasSize = UDim2.new(0, 0, 0, GamesLayout.AbsoluteContentSize.Y)
    end)
end

local function FetchData()
    local success, result = pcall(function()
        return loadstring(game:HttpGet(GameListURL))()
    end)
    
    if success and type(result) == "table" then
        FetchedData = result
        RenderGames()
        if SelectedGameName then
            RenderScripts(SelectedGameName)
        end
    end
end

local function showMain()
    KeyFrame.Visible = false
    Main.Visible = true
    ToggleIcon.Visible = true
    FetchData()
    RunService.Heartbeat:Connect(function()
        if tick() - LastRefresh >= 2 then
            LastRefresh = tick()
            FetchData()
        end
    end)
end

local function validateAndProceed(key)
    if not key or #key == 0 then
        StatusLabel.Text = "Please enter a key"
        StatusLabel.TextColor3 = Color3.fromRGB(220, 70, 70)
        return
    end
    StatusLabel.Text = "Validating..."
    StatusLabel.TextColor3 = Color3.fromRGB(242, 133, 0)
    CheckKeyBtn.Text = "Checking..."
    local validation = Junkie.check_key(key)
    if validation and validation.valid then
        saveKey(key)
        getgenv().SCRIPT_KEY = key
        StatusLabel.Text = "Key valid"
        StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 80)
        CheckKeyBtn.Text = "Check Key"
        task.wait(0.6)
        showMain()
    else
        local err = (validation and (validation.error or validation.message)) or "Invalid key"
        StatusLabel.Text = tostring(err)
        StatusLabel.TextColor3 = Color3.fromRGB(220, 70, 70)
        CheckKeyBtn.Text = "Check Key"
    end
end

GetKeyBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Getting link..."
    StatusLabel.TextColor3 = Color3.fromRGB(242, 133, 0)
    local link, err = Junkie.get_key_link()
    if link then
        if setclipboard then
            setclipboard(link)
            StatusLabel.Text = "Key link copied to clipboard"
            StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 80)
        else
            StatusLabel.Text = link
            StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 80)
        end
    else
        StatusLabel.Text = err or "Rate limited. Wait 5 minutes"
        StatusLabel.TextColor3 = Color3.fromRGB(220, 70, 70)
    end
end)

CheckKeyBtn.MouseButton1Click:Connect(function()
    validateAndProceed(KeyBox.Text:gsub("%s+", ""))
end)

KeyBox.FocusLost:Connect(function(enter)
    if enter then
        validateAndProceed(KeyBox.Text:gsub("%s+", ""))
    end
end)

LoadBtn.MouseButton1Click:Connect(function()
    if SelectedScriptData and SelectedScriptData.url then
        LoadBtn.Text = "Executing..."
        local success, err = pcall(function()
            loadstring(game:HttpGet(SelectedScriptData.url))()
        end)
        
        if success then
            LoadBtn.Text = "Success"
        else
            LoadBtn.Text = "Error"
            warn("Syscall Loader Execution Error:", err)
        end
        
        task.delay(2, function()
            LoadBtn.Text = "Load Script"
        end)
    else
        LoadBtn.Text = "Select Script"
        task.delay(1.5, function()
            LoadBtn.Text = "Load Script"
        end)
    end
end)

UnloadBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
  end
