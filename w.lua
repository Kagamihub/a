--[ カミによる論理構築: 統合制御インターフェース ]--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUIの親要素
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "KAMI_CONTROL_SYSTEM"

-- メインパネル
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0, 20, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)

-- タイトル
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "KAMI: COORDINATE ANALYZER"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextSize = 12

-- 座標入力フィールド (X, Y, Zをカンマ区切りで入力)
local InputBox = Instance.new("TextBox", MainFrame)
InputBox.Size = UDim2.new(0.9, 0, 0, 30)
InputBox.Position = UDim2.new(0.05, 0, 0.3, 0)
InputBox.PlaceholderText = "X, Y, Z (e.g. 100, 50, -20)"
InputBox.Text = ""
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ステータス表示
local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 40)
StatusLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
StatusLabel.Text = "WAITING FOR INPUT..."
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 10

-- 追跡用マーカー（画面上の点）
local Marker = Instance.new("Frame", ScreenGui)
Marker.Size = UDim2.new(0, 12, 0, 12)
Marker.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Marker.AnchorPoint = Vector2.new(0.5, 0.5)
Marker.Visible = false

local targetPos = Vector3.new(0, 0, 0)

-- リアルタイム解析ループ
RunService.RenderStepped:Connect(function()
    -- 入力文字列から座標を解析
    local coords = {}
    for val in string.gmatch(InputBox.Text, "-?%d+%.?%d*") do
        table.insert(coords, tonumber(val))
    end
    
    if #coords >= 3 then
        targetPos = Vector3.new(coords[1], coords[2], coords[3])
        
        local screenPos, onScreen = Camera:WorldToScreenPoint(targetPos)
        if onScreen then
            Marker.Visible = true
            Marker.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)
            
            local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) 
                and (LocalPlayer.Character.HumanoidRootPart.Position - targetPos).Magnitude or 0
            StatusLabel.Text = string.format("LOCKED: [%d, %d, %d]\nDIST: %.1f", targetPos.X, targetPos.Y, targetPos.Z, dist)
        else
            Marker.Visible = false
            StatusLabel.Text = "OUT OF RANGE"
        end
    else
        Marker.Visible = false
        StatusLabel.Text = "INVALID COORDINATES"
    end
end)
