local a = Instance.new("ScreenGui", game:GetService("CoreGui"))
local b = Instance.new("Frame", a)
local c = Instance.new("UIStroke", b)
local d = Instance.new("UICorner", b)
local e = Instance.new("TextLabel", b)
local f = Instance.new("Frame", b)
local g = Instance.new("TextButton", b)
local h = Instance.new("UIStroke", g)
local i = Instance.new("UICorner", g)

-- 基本設定（メイン枠を「白」に反転）
a.Name = tostring(math.random(1e5, 9e5))
b.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- 陽（白背景）
b.Position = UDim2.new(0.5, -105, 0.5, -62)
b.Size = UDim2.new(0, 210, 0, 125)
b.Active = true 
b.Draggable = true 

d.CornerRadius = UDim.new(0, 12)
c.Color = Color3.fromRGB(0, 0, 0) -- 陰（黒の境界線）
c.Thickness = 2
c.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- タイトル: KAGAMI HUB（文字を「黒」に反転）
e.BackgroundTransparency = 1
e.Position = UDim2.new(0, 0, 0, 8)
e.Size = UDim2.new(1, 0, 0, 20)
e.Font = Enum.Font.GothamBold
e.Text = "KAGAMI HUB"
e.TextColor3 = Color3.fromRGB(0, 0, 0) -- 黒文字
e.TextSize = 16
e.TextXAlignment = Enum.TextXAlignment.Center

-- 区切り線（黒）
f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
f.BackgroundTransparency = 0.8
f.BorderSizePixel = 0
f.Position = UDim2.new(0, 20, 0, 35)
f.Size = UDim2.new(0, 170, 0, 1)

-- ボタン設定
g.Position = UDim2.new(0, 20, 0, 55)
g.Size = UDim2.new(0, 170, 0, 50)
g.Font = Enum.Font.GothamBold
g.TextSize = 14
g.AutoButtonColor = false
g.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- ボタンは最初は「黒」
g.Text = "SYSTEM IDLE"
g.TextColor3 = Color3.fromRGB(255, 255, 255) -- 文字は「白」

h.Thickness = 2
h.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
h.Color = Color3.fromRGB(0, 0, 0)
i.CornerRadius = UDim.new(0, 6)

-- ロジック部分
local j = false 
local k = game:GetService("Players").LocalPlayer 
local l = {"bat","laser cape","laser gun"}

local function m()
    local n = {}
    local o = k:FindFirstChild("Backpack")
    local p = k.Character 
    local function q(r)
        if r then 
            for s,t in ipairs(r:GetChildren()) do 
                if t:IsA("Tool") then 
                    for u,v in ipairs(l) do 
                        if string.find(string.lower(t.Name),v) then 
                            table.insert(n,t)
                        end 
                    end 
                end 
            end 
        end 
    end 
    q(o)
    q(p)
    return n 
end 

g.MouseButton1Click:Connect(function()
    j = not j 
    if j then 
        -- 有効時：ボタンを白背景・黒文字に反転
        g.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        g.Text = "LAG ACTIVE"
        g.TextColor3 = Color3.fromRGB(0, 0, 0)
        h.Color = Color3.fromRGB(0, 0, 0)
        
        task.spawn(function()
            while j do 
                local p = k.Character 
                local o = k:FindFirstChild("Backpack")
                if p and o then 
                    local n = m()
                    if #n > 0 then 
                        for s,t in ipairs(n) do 
                            if not j then break end 
                            t.Parent = p 
                            t:Activate()
                            task.wait(0.08)
                            if t.Parent == p then t.Parent = o end 
                        end 
                    else 
                        task.wait(0.5)
                    end 
                else 
                    task.wait(0.1)
                end 
            end 
        end)
    else 
        -- 無効時：ボタンを黒背景・白文字に戻す
        g.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        g.Text = "LAG DISABLED"
        g.TextColor3 = Color3.fromRGB(255, 255, 255)
        h.Color = Color3.fromRGB(0, 0, 0)
        
        local p = k.Character 
        local o = k:FindFirstChild("Backpack")
        if p and o then 
            for s,t in ipairs(p:GetChildren()) do 
                if t:IsA("Tool") then t.Parent = o end 
            end 
        end 
    end 
end)
