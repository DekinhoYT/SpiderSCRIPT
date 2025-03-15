local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getHiddenKey()
    return string.char(75, 69, 89, 45, 68, 69, 75, 49, 50, 51, 52)
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local UICorner = Instance.new("UICorner", Frame)
local UIStroke = Instance.new("UIStroke", Frame)

Frame.Size = UDim2.new(0, 350, 0, 250)
Frame.Position = UDim2.new(0.5, -175, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 2
UICorner.CornerRadius = UDim.new(0, 12)

local dragging, dragInput, mousePos, offset = false, nil, nil, nil

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        offset = Frame.Position - UDim2.new(0, input.Position.X, 0, input.Position.Y)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            mousePos = input.Position
            Frame.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y) + offset
        end
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
TextBox.PlaceholderText = "Digite a Key"
TextBox.TextScaled = true
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
local UICornerBox = Instance.new("UICorner", TextBox)
UICornerBox.CornerRadius = UDim.new(0, 6)

local function createButton(text, pos, callback)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(0.8, 0, 0, 40)
    Button.Position = pos
    Button.Text = text
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    local UICornerBtn = Instance.new("UICorner", Button)
    UICornerBtn.CornerRadius = UDim.new(0, 6)
    
    Button.MouseButton1Click:Connect(function()
        Button:TweenSize(UDim2.new(0.85, 0, 0, 38), "Out", "Quad", 0.1, true)
        wait(0.1)
        Button:TweenSize(UDim2.new(0.8, 0, 0, 40), "Out", "Quad", 0.1, true)
        callback()
    end)
end

createButton("Pegar Key", UDim2.new(0.1, 0, 0.4, 0), function()
    setclipboard("https://fir3.net/KEYPASS3")
    game.StarterGui:SetCore("SendNotification", {Title = "Key System", Text = "Link copiado!", Duration = 2})
end)

createButton("Verificar Key", UDim2.new(0.1, 0, 0.6, 0), function()
    local key = TextBox.Text
    
    if key == getHiddenKey() then
        game.StarterGui:SetCore("SendNotification", {Title = "Sucesso!", Text = "Key correta!", Duration = 2})
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpineWare/UniversalLoader/refs/heads/main/Load"))()
        ScreenGui:Destroy()
    else
        game.StarterGui:SetCore("SendNotification", {Title = "Erro!", Text = "Key inválida!", Duration = 2})
    end
end)

createButton("Discord", UDim2.new(0.1, 0, 0.8, 0), function()
    setclipboard("https://discord.gg/Bkdxtu4e6A")
    game.StarterGui:SetCore("SendNotification", {Title = "Discord", Text = "Convite copiado!", Duration = 2})
end)

local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local MinimizeButton = Instance.new("TextButton", Frame)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.MouseButton1Click:Connect(function()
    if Frame.Size == UDim2.new(0, 350, 0, 250) then
        Frame:TweenSize(UDim2.new(0, 350, 0, 40), "Out", "Quad", 0.3, true)
    else
        Frame:TweenSize(UDim2.new(0, 350, 0, 250), "Out", "Quad", 0.3, true)
    end
end)
