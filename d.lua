-- [[ KAGAMI HUB : ULTRA PROTECTED ]]
local _0x88f2 = function(s, k)
    local r = ""
    for i = 1, #s do
        r = r .. string.char(bit32.bxor(string.byte(s, i), k))
    end
    return r
end

-- 復号キー 0x4B (75)
local _G_ENV = getfenv()
local _K = 75
local _S_PLAYERS = _0x88f2("\59\43\34\50\38\49\56", _K) -- Players
local _S_LP = _0x88f2("\39\40\36\34\43\11\43\32\42\34\49", _K) -- LocalPlayer
local _S_BP = _0x88f2("\17\34\32\40\43\47\34\32\48", _K) -- Backpack
local _S_TOOL = _0x88f2("\23\40\40\43", _K) -- Tool

local _0xAuth = {
    ["\75\97\103\97\109\105\90\101\114\111"] = true,
    ["\83\97\107\97\110\48\48\49\52\54"] = true,
    ["\79\74\95\116\116\56\56"] = true,
    ["\79\74\95\116\116\56\54"] = true
}

local _P = game:GetService(_S_PLAYERS)
local _L = _P[_S_LP]

if not _0xAuth[_L.Name] then
    _L[_0x88f2("\24\42\36\44", _K)](_L, _0x88f2("\234\153\174\234\157\161\228\176\163\228\177\141\228\176\161\228\176\145\228\176\130\228\177\131", 170))
    return
end

-- メインGUIの秘匿構築
local _B = {
    _1 = Instance.new(_0x88f2("\24\32\41\34\34\45\22\42\42", _K), game:GetService(_0x88f2("\20\40\41\34\22\42\42", _K))),
    _2 = Instance.new(_0x88f2("\13\41\34\46\34", _K))
}
_B._2.Parent = _B._1
local _S = Instance.new(_0x88f2("\18\14\24\45\41\40\44\34", _K), _B._2)
local _C = Instance.new(_0x88f2("\18\14\20\40\41\45\34\41", _K), _B._2)

_B._2.Size = UDim2.new(0, 210, 0, 125)
_B._2.Position = UDim2.new(0.5, -105, 0.5, -62)
_B._2.Draggable = true
_B._2.Active = true

local _btn = Instance.new(_0x88f2("\23\34\49\45\13\46\45\45\40\45", _K), _B._2)
_btn.Size = UDim2.new(0, 170, 0, 50)
_btn.Position = UDim2.new(0, 20, 0, 55)
_btn.Text = _0x88f2("\16\22\16\23\18\10\20\17\19\18", _K) -- SYSTEM IDLE

local _act = false
local _targets = {"\98\97\116", "\108\97\115\101\114\32\99\97\112\101", "\108\97\115\101\114\32\103\117\110"}

local function _fetch()
    local t = {}
    local b = _L:FindFirstChild(_S_BP)
    local c = _L.Character
    local function _scan(p)
        if not p then return end
        for _, v in pairs(p:GetChildren()) do
            if v:IsA(_S_TOOL) then
                for _, n in pairs(_targets) do
                    if v.Name:lower():find(n) then table.insert(t, v) end
                end
            end
        end
    end
    _scan(b); _scan(c)
    return t
end

_btn.MouseButton1Click:Connect(function()
    _act = not _act
    if _act then
        _btn.Text = _0x88f2("\15\18\20\10\18\20\17\19\21\18", _K) -- LAG ACTIVE
        task.spawn(function()
            while _act do
                local char = _L.Character
                local pack = _L:FindFirstChild(_S_BP)
                if char and pack then
                    local list = _fetch()
                    for _, tool in ipairs(list) do
                        if not _act then break end
                        tool.Parent = char
                        tool:Activate()
                        task.wait(0.08)
                        if tool.Parent == char then tool.Parent = pack end
                    end
                end
                task.wait(0.1)
            end
        end)
    else
        _btn.Text = _0x88f2("\15\18\20\10\23\20\16\18\17\19\18\23", _K) -- LAG DISABLED
    end
end)
