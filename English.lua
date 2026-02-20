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
    Title = "加载LuaWareUI[silentUI]版本",
    Description = "UI简洁经典，加载快速\n目前为最新版本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/silentUI.luau"))()
    end
})
Tabs.Main:AddButton({
    Title = "复制LuaWareUI版本",
    Callback = function()
        setclipboard('loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/silentUI.luau"))()')
    end
})

Tabs.Main:AddButton({
    Title = "加载windUI版本",
    Description = "UI好看实用，加载较慢\n目前为旧版本，可能不会再更新",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/WindUI.luau",true))()
    end
})
Tabs.Main:AddButton({
    Title = "复制windUI版本",
    Callback = function()
        setclipboard('loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/main/WindUI.luau",true))()')
    end
})

Window:SelectTab(1)