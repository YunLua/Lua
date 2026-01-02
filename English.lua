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

Tabs.Main:AddParagraph({
    Title = "反馈",
    Content = "请加入新群号996419273"
})

Tabs.Main:AddButton({
    Title = "加载LuaWareUI[silentUI]版本",
    Description = "UI简洁经典，加载快",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/silentUI.luau"))()
    end
})

Tabs.Main:AddButton({
    Title = "加载windUI版本",
    Description = "UI好看实用，加载较慢",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/WindUI.luau",true))()
    end
})

Window:SelectTab(1)