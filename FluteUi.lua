local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UI = {}
function UI:New(cfg)
local sg = Instance.new("ScreenGui")
sg.Name = "CustomUI"
sg.Parent = CoreGui
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local theme = cfg.Theme or {Primary = Color3.fromRGB(99,102,241), Secondary = Color3.fromRGB(139,92,246), BG = Color3.fromRGB(15,15,30), Card = Color3.fromRGB(26,26,46)}
local loading = Instance.new("Frame")
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = theme.BG
loading.BorderSizePixel = 0
loading.Parent = sg
local ltxt = Instance.new("TextLabel")
ltxt.Size = UDim2.new(0,200,0,50)
ltxt.Position = UDim2.new(0.5,-100,0.5,-25)
ltxt.BackgroundTransparency = 1
ltxt.Text = cfg.Title or "Loading..."
ltxt.TextColor3 = Color3.new(1,1,1)
ltxt.Font = Enum.Font.GothamBold
ltxt.TextSize = 24
ltxt.Parent = loading
task.wait(2)
loading:Destroy()
local main = Instance.new("Frame")
main.Size = UDim2.new(0,800,0,500)
main.Position = UDim2.new(0.5,-400,0.5,-250)
main.BackgroundColor3 = theme.Card
main.BorderSizePixel = 0
main.Parent = sg
local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0,16)
mc.Parent = main
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,72)
header.BackgroundColor3 = theme.Primary
header.BorderSizePixel = 0
header.Parent = main
local hg = Instance.new("UIGradient")
hg.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,theme.Primary),ColorSequenceKeypoint.new(1,theme.Secondary)}
hg.Rotation = 90
hg.Parent = header
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-48,0,30)
title.Position = UDim2.new(0,24,0,16)
title.BackgroundTransparency = 1
title.Text = cfg.Title or "Custom GUI"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1,-48,0,20)
subtitle.Position = UDim2.new(0,24,0,46)
subtitle.BackgroundTransparency = 1
subtitle.Text = cfg.Subtitle or "v1.0.0"
subtitle.TextColor3 = Color3.new(1,1,1)
subtitle.TextTransparency = 0.4
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,200,1,-72)
sidebar.Position = UDim2.new(0,0,0,72)
sidebar.BackgroundColor3 = Color3.fromRGB(theme.Card.R*255*0.8,theme.Card.G*255*0.8,theme.Card.B*255*0.8)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
local sbl = Instance.new("UIListLayout")
sbl.Padding = UDim.new(0,4)
sbl.Parent = sidebar
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-200,1,-72)
content.Position = UDim2.new(0,200,0,72)
content.BackgroundTransparency = 1
content.Parent = main
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-24,1,-24)
scroll.Position = UDim2.new(0,12,0,12)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = theme.Primary
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.Parent = content
local clist = Instance.new("UIListLayout")
clist.Padding = UDim.new(0,8)
clist.Parent = scroll
clist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
scroll.CanvasSize = UDim2.new(0,0,0,clist.AbsoluteContentSize.Y)
end)
local tabs = {}
for i,tab in ipairs(cfg.Tabs) do
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,-16,0,40)
btn.BackgroundColor3 = i==1 and theme.Primary or Color3.fromRGB(theme.Card.R*255,theme.Card.G*255,theme.Card.B*255)
btn.BackgroundTransparency = i==1 and 0.3 or 1
btn.BorderSizePixel = 0
btn.Text = "  "..tab.Name
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamSemibold
btn.TextSize = 14
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = sidebar
local bc = Instance.new("UICorner")
bc.CornerRadius = UDim.new(0,8)
bc.Parent = btn
local container = Instance.new("Frame")
container.Size = UDim2.new(1,0,0,0)
container.BackgroundTransparency = 1
container.Visible = i==1
container.Parent = scroll
tabs[i] = {Button = btn, Container = container, Data = tab}
btn.MouseButton1Click:Connect(function()
for _,t in ipairs(tabs) do
t.Container.Visible = false
TweenService:Create(t.Button,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
end
container.Visible = true
TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundTransparency=0.3}):Play()
end)
end
local lib = {Tabs=tabs}
function lib:AddButton(tabIdx,txt,cb)
local t = tabs[tabIdx].Container
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,0,0,36)
btn.BackgroundColor3 = theme.Primary
btn.BackgroundTransparency = 0.9
btn.BorderSizePixel = 0
btn.Text = txt
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamSemibold
btn.TextSize = 14
btn.Parent = t
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,8)
c.Parent = btn
btn.MouseButton1Click:Connect(cb)
btn.MouseEnter:Connect(function()
TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundTransparency=0.7}):Play()
end)
btn.MouseLeave:Connect(function()
TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundTransparency=0.9}):Play()
end)
end
function lib:AddToggle(tabIdx,txt,def,cb)
local t = tabs[tabIdx].Container
local fr = Instance.new("Frame")
fr.Size = UDim2.new(1,0,0,36)
fr.BackgroundColor3 = theme.Primary
fr.BackgroundTransparency = 0.9
fr.BorderSizePixel = 0
fr.Parent = t
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,8)
c.Parent = fr
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1,-60,1,0)
lbl.Position = UDim2.new(0,12,0,0)
lbl.BackgroundTransparency = 1
lbl.Text = txt
lbl.TextColor3 = Color3.new(1,1,1)
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 14
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = fr
local tog = Instance.new("TextButton")
tog.Size = UDim2.new(0,40,0,20)
tog.Position = UDim2.new(1,-48,0.5,-10)
tog.BackgroundColor3 = def and theme.Primary or Color3.fromRGB(60,60,80)
tog.BorderSizePixel = 0
tog.Text = ""
tog.Parent = fr
local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(1,0)
tc.Parent = tog
local ind = Instance.new("Frame")
ind.Size = UDim2.new(0,16,0,16)
ind.Position = def and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
ind.BackgroundColor3 = Color3.new(1,1,1)
ind.BorderSizePixel = 0
ind.Parent = tog
local ic = Instance.new("UICorner")
ic.CornerRadius = UDim.new(1,0)
ic.Parent = ind
local state = def
tog.MouseButton1Click:Connect(function()
state = not state
TweenService:Create(tog,TweenInfo.new(0.2),{BackgroundColor3=state and theme.Primary or Color3.fromRGB(60,60,80)}):Play()
TweenService:Create(ind,TweenInfo.new(0.2),{Position=state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)}):Play()
cb(state)
end)
end
function lib:AddInput(tabIdx,txt,ph,cb)
local t = tabs[tabIdx].Container
local fr = Instance.new("Frame")
fr.Size = UDim2.new(1,0,0,36)
fr.BackgroundColor3 = theme.Primary
fr.BackgroundTransparency = 0.9
fr.BorderSizePixel = 0
fr.Parent = t
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,8)
c.Parent = fr
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(0,100,1,0)
lbl.Position = UDim2.new(0,12,0,0)
lbl.BackgroundTransparency = 1
lbl.Text = txt
lbl.TextColor3 = Color3.new(1,1,1)
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 14
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = fr
local inp = Instance.new("TextBox")
inp.Size = UDim2.new(1,-130,0,28)
inp.Position = UDim2.new(0,116,0,4)
inp.BackgroundColor3 = Color3.fromRGB(30,30,50)
inp.BorderSizePixel = 0
inp.PlaceholderText = ph
inp.Text = ""
inp.TextColor3 = Color3.new(1,1,1)
inp.Font = Enum.Font.Gotham
inp.TextSize = 13
inp.Parent = fr
local ic = Instance.new("UICorner")
ic.CornerRadius = UDim.new(0,6)
ic.Parent = inp
inp.FocusLost:Connect(function()
cb(inp.Text)
end)
end
function lib:AddParagraph(tabIdx,txt)
local t = tabs[tabIdx].Container
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1,0,0,0)
lbl.BackgroundTransparency = 1
lbl.Text = txt
lbl.TextColor3 = Color3.new(0.8,0.8,0.8)
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 13
lbl.TextWrapped = true
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.TextYAlignment = Enum.TextYAlignment.Top
lbl.Parent = t
lbl.Size = UDim2.new(1,0,0,lbl.TextBounds.Y)
end
function lib:AddSeparator(tabIdx,txt)
local t = tabs[tabIdx].Container
local fr = Instance.new("Frame")
fr.Size = UDim2.new(1,0,0,20)
fr.BackgroundTransparency = 1
fr.Parent = t
local ln = Instance.new("Frame")
ln.Size = UDim2.new(1,txt and -100 or 0,0,1)
ln.Position = UDim2.new(0,0,0.5,0)
ln.BackgroundColor3 = theme.Primary
ln.BackgroundTransparency = 0.7
ln.BorderSizePixel = 0
ln.Parent = fr
if txt then
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(0,90,1,0)
lbl.Position = UDim2.new(1,-90,0,0)
lbl.BackgroundTransparency = 1
lbl.Text = txt
lbl.TextColor3 = theme.Primary
lbl.Font = Enum.Font.GothamSemibold
lbl.TextSize = 12
lbl.Parent = fr
end
end
return lib
end
return UI


