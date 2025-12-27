local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "云脚本",
    Size = UDim2.fromOffset(460, 310),
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
        loadstring(game:HttpGet("https://github.com/YunLua/Lua/raw/main/silentUI.luau", true))()
    end
})

Tabs.Main:AddButton({
    Title = "加载windUI版本",
    Description = "UI好看实用，加载较慢",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/YunLua/Lua/raw/main/WindUI.luau", true))()
    end
})
