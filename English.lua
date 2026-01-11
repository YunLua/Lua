do
    print = function() end
    warn  = function() end

    if rconsoleprint then rconsoleprint = function() end end
    if rconsolewarn  then rconsolewarn  = function() end end
    if rconsoleerr   then rconsoleerr   = function() end end
    if rconsoleinfo  then rconsoleinfo  = function() end end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "云脚本",
    Size = UDim2.fromOffset(460, 310),
    TabWidth = 160,
    Theme = "Darker"
})

local Tabs = {
    Main = Window:AddTab({ Title = "请选择UI", Icon = "box" })
}

Tabs.Main:AddButton({
    Title = "自动翻译",
    Callback = function()
--由47制作
local Http, Players, CoreGui = game:GetService("HttpService"), game:GetService("Players"), game:GetService("CoreGui")
local request = request or http_request or (syn and syn.request) or (fluxus and fluxus.request) --意义不明qwq
if not (request and hookmetamethod) then return end

local Encode, Decode, Spawn = Http.UrlEncode, Http.JSONDecode, task.spawn
local Cache, Queue, RealText, Locks = {}, {}, setmetatable({}, {__mode="k"}), {}
local API = "https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=auto&tl=zh-CN&q="

local OldIdx; OldIdx = hookmetamethod(game, "__index", function(t, k)
    return (k == "Text" and not checkcaller() and RealText[t]) or OldIdx(t, k)
end)

local function SetTrans(obj, origin, trans, vars)
    if obj.Text ~= origin then return end
    local k = 0
    local val = trans:gsub("%s?{[nN]}%s?", function() k=k+1 return vars[k] or "" end)
    if obj.Text ~= val then Locks[obj]=1; RealText[obj]=origin; obj.Text=val; Locks[obj]=nil end
end

local function Process(obj)
    if Locks[obj] then return end
    local txt = obj.Text
    if #txt < 2 or txt:match("^[%d%s%p]+$") then return end

    local vars = {}
    local skel = txt:gsub("[%+$%-¥]?%d+[%d%.%,:]*[%d%%]*", function(m) vars[#vars+1]=m return "{n}" end)

    if Cache[skel] then return SetTrans(obj, txt, Cache[skel], vars) end

    local q = Queue[skel]; if q then q[#q+1] = {obj, vars, txt} return end
    Queue[skel] = {{obj, vars, txt}}

    Spawn(function()
        local s, r = pcall(request, {Url = API..Encode(Http, skel), Method = "GET"})
        local d = s and r.StatusCode == 200 and Decode(Http, r.Body)
        local res = type(d)=="table" and (type(d[1])=="string" and d[1] or d[1][1])

        if res then
            Cache[skel] = res
            for _, i in next, Queue[skel] do
                local _ = i[1].Parent and SetTrans(i[1], i[3], res, i[2]) 
            end
        end
        Queue[skel] = nil
    end)
end

local function Init(v)
    if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
        Process(v); v:GetPropertyChangedSignal("Text"):Connect(function() Process(v) end)
    end
end

local Roots = {Players.LocalPlayer:WaitForChild("PlayerGui"), (gethui and gethui()) or CoreGui, workspace}
for _, root in next, Roots do
    Spawn(function()
        for _, v in next, root:GetDescendants() do Init(v) end
        root.DescendantAdded:Connect(Init)
    end)
end
    end
})

Tabs.Main:AddParagraph({
    Title = "反馈",
    Content = "请加入新群号996419273"
})

Tabs.Main:AddButton({
    Title = "加载LuaWareUI[silentUI]版本",
    Description = "UI简洁经典，加载快速\n目前为最新版本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/silentUI.luau"))()
    end
})

Tabs.Main:AddButton({
    Title = "加载windUI版本",
    Description = "UI好看实用，加载较慢\n目前为旧版本，可能不会再更新",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/WindUI.luau",true))()
    end
})

Window:SelectTab(1)

loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/refs/heads/main/KFC.lua", true))()