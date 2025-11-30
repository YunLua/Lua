local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
Title = "小猪-云脚本[测试版]",
Size = UDim2.fromOffset(180, 190),
Theme = "Dark",
})
local l = Window:Tab({
Title = "通用",
Icon = "users",
Locked = false,
})
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local guiVisible = false
local guiDraggable = true
local guiSize = UDim2.new(0, 296, 0, 388)
local guiPosition = UDim2.new(0.08, 0, 0.42, 0)
local PiggyGui = Instance.new("ScreenGui")
PiggyGui.Name = "PiggyGui"
PiggyGui.Parent = game.CoreGui
PiggyGui.ResetOnSpawn = false
PiggyGui.DisplayOrder = 999
local MainFrame = Instance.new("Frame", PiggyGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Size = guiSize
MainFrame.Position = guiPosition
MainFrame.ClipsDescendants = true
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.ZIndex = 2
local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Text = "物品列表[双击刷新]"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 5, 0, 0)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.Gotham
TitleText.TextSize = 14
local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 25)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -25)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
local UIGridLayout = Instance.new("UIGridLayout", ScrollingFrame)
UIGridLayout.CellSize = UDim2.new(0, 90, 0, 90)
UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local ResizeHandle = Instance.new("TextButton", MainFrame)
ResizeHandle.Name = "ResizeHandle"
ResizeHandle.Text = ""
ResizeHandle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ResizeHandle.Size = UDim2.new(0, 10, 0, 10)
ResizeHandle.Position = UDim2.new(1, -10, 1, -10)
ResizeHandle.ZIndex = 2
l:Toggle({
Title = "显示物品列表",
Desc = "提示：你看到的物品可能暂时不生效，开始游戏或者结束游戏后效果会恢复正常，",
Value = false,
Callback = function(v)
guiVisible = v
PiggyGui.Enabled = v
end
})
l:Slider({
Title = "宽度",
Value = { Min = 100, Max = 600, Default = guiSize.X.Offset },
Callback = function(v)
guiSize = UDim2.new(0, v, guiSize.Y.Scale, guiSize.Y.Offset)
MainFrame.Size = guiSize
end
})
l:Slider({
Title = "高度",
Value = { Min = 100, Max = 800, Default = guiSize.Y.Offset },
Callback = function(v)
guiSize = UDim2.new(guiSize.X.Scale, guiSize.X.Offset, 0, v)
MainFrame.Size = guiSize
end
})
local dragging = false
local dragInput
local dragStart
local startPos
TitleBar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 and guiDraggable then
dragging = true
dragStart = input.Position
startPos = MainFrame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
TitleBar.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
dragInput = input
end
end)
UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
MainFrame.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)
local resizing = false
local resizeStart
local startSize
ResizeHandle.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
resizing = true
resizeStart = input.Position
startSize = MainFrame.Size
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
resizing = false
end
end)
end
end)
ResizeHandle.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement and resizing then
dragInput = input
end
end)
UserInputService.InputChanged:Connect(function(input)
if input == dragInput and resizing then
local delta = input.Position - resizeStart
local newSize = UDim2.new(
startSize.X.Scale,
math.max(200, startSize.X.Offset + delta.X),
startSize.Y.Scale,
math.max(200, startSize.Y.Offset + delta.Y)
)
MainFrame.Size = newSize
guiSize = newSize
end
end)
CloseButton.MouseButton1Click:Connect(function()
guiVisible = false
PiggyGui.Enabled = false
end)
TitleText.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then
if tick() - (LastClickTime or 0) < 0.3 then
refreshItems()
end
LastClickTime = tick()
end
end)
local function refreshItems()
for _, child in ipairs(ScrollingFrame:GetChildren()) do
if child:IsA("TextButton") and child.Name == "ItemFrame" then
child:Destroy()
end
end
local items = {}
for _, descendant in ipairs(workspace:GetDescendants()) do
if descendant.Name == "ItemPickupScript" and descendant.Parent:FindFirstChild("ClickDetector") then
table.insert(items, descendant.Parent)
end
end
for i, item in ipairs(items) do
local ItemFrame = Instance.new("TextButton", ScrollingFrame)
ItemFrame.Name = "ItemFrame"
ItemFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ItemFrame.BackgroundTransparency = 0.95
ItemFrame.Size = UDim2.new(0, 90, 0, 90)
ItemFrame.Text = ""
ItemFrame.ZIndex = 2
local View = Instance.new("ViewportFrame", ItemFrame)
View.Name = "View"
View.Size = UDim2.new(1, 0, 1, 0)
View.BackgroundTransparency = 1
View.BorderSizePixel = 0
local viewportclone = item:Clone()
viewportclone.Parent = View
local cam = Instance.new("Camera")
cam.Parent = View
cam.CameraType = Enum.CameraType.Scriptable
local objectPosition = item.Position
local cameraPosition = objectPosition + Vector3.new(0, 3, 0)
cam.CFrame = CFrame.new(cameraPosition, objectPosition)
View.CurrentCamera = cam
local ItemName = Instance.new("TextLabel", ItemFrame)
ItemName.Name = "ItemName"
ItemName.Text = item.Name
ItemName.TextColor3 = Color3.new(1, 1, 1)
ItemName.BackgroundColor3 = Color3.new(0, 0, 0)
ItemName.BackgroundTransparency = 0.5
ItemName.Size = UDim2.new(1, 0, 0, 20)
ItemName.Position = UDim2.new(0, 0, 0, -20)
ItemName.Font = Enum.Font.Gotham
ItemName.TextSize = 12
ItemName.ZIndex = 3
ItemFrame.MouseButton1Down:Connect(function()
if item:FindFirstChild("ClickDetector") then
local char = game.Players.LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
local cpos = char.HumanoidRootPart.CFrame
char.HumanoidRootPart.CFrame = item.CFrame
task.wait(0.1)
fireclickdetector(item.ClickDetector)
task.wait(0.3)
char.HumanoidRootPart.CFrame = cpos
task.wait(0.5)
refreshItems()
end
end
end)
end
local itemCount = #items
local rows = math.ceil(itemCount / math.floor(ScrollingFrame.AbsoluteSize.X / 95))
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, rows * 95)
end
spawn(function()
while task.wait(5) do
if guiVisible then
refreshItems()
end
end
end)
refreshItems()
