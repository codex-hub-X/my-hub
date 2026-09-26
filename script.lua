local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LP:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("CodexUI_V8_Template") then 
	PlayerGui.CodexUI_V8_Template:Destroy() 
end

local SG = Instance.new("ScreenGui", PlayerGui)
SG.Name = "CodexUI_V8_Template"
SG.ResetOnSpawn = false

-- TOGGLE BUTTON (NÚT TRÒN MỞ MENU)
local Tog = Instance.new("TextButton", SG)
Tog.Size = UDim2.new(0, 50, 0, 50)
Tog.Position = UDim2.new(0, 20, 0.45, 0)
Tog.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Tog.BackgroundTransparency = 0.15
Tog.Text = "⚡"
Tog.TextColor3 = Color3.fromRGB(255, 215, 80)
Tog.TextSize = 24
Tog.Draggable = true
Tog.Active = true
Instance.new("UICorner", Tog).CornerRadius = UDim.new(1, 0)

local TogStroke = Instance.new("UIStroke", Tog)
TogStroke.Color = Color3.fromRGB(255, 215, 80)
TogStroke.Thickness = 1.8

-- MAIN FRAME (NGANG 580, CAO 320)
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 580, 0, 320)
Main.Position = UDim2.new(0.5, -290, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Main.BackgroundTransparency = 0.15
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Gradient = Instance.new("UIGradient", MainStroke)
Gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 90)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 55, 10)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 220, 90))
})

RunService.RenderStepped:Connect(function()
	Gradient.Rotation = (Gradient.Rotation + 1.2) % 360
end)

-- BANNER ANIME
local AnimeBanner = Instance.new("ImageLabel", Main)
AnimeBanner.Name = "AnimeBanner"
AnimeBanner.Size = UDim2.new(1, 0, 0, 70)
AnimeBanner.Position = UDim2.new(0, 0, 0, 0)
AnimeBanner.BackgroundTransparency = 1
AnimeBanner.Image = "rbxassetid://10620641162"
AnimeBanner.ScaleType = Enum.ScaleType.Crop
AnimeBanner.ClipsDescendants = true
Instance.new("UICorner", AnimeBanner).CornerRadius = UDim.new(0, 16)

-- NHÂN VẬT ANIME ĐỨNG HÔNG
local AnimeChar = Instance.new("ImageLabel", Main)
AnimeChar.Name = "AnimeChar"
AnimeChar.Size = UDim2.new(0, 130, 0, 190)
AnimeChar.Position = UDim2.new(1, -25, 0.5, -80)
AnimeChar.BackgroundTransparency = 1
AnimeChar.Image = "rbxassetid://10620641162"
AnimeChar.ScaleType = Enum.ScaleType.Fit
AnimeChar.ZIndex = 10

-- HEADER TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 8)
Title.Text = "⚡ CODEX HUB V8 - FRAMEWORK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.ZIndex = 2

-- SIDEBAR TABS
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -80)
Sidebar.Position = UDim2.new(0, 10, 0, 75)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.BackgroundTransparency = 0.4
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- CONTAINER NỘI DUNG TABS
local ContentContainer = Instance.new("Frame", Main)
ContentContainer.Size = UDim2.new(1, -250, 1, -80)
ContentContainer.Position = UDim2.new(0, 150, 0, 75)
ContentContainer.BackgroundTransparency = 1

local Tabs = {}
local function CreateTab(name, active)
	local TabBtn = Instance.new("TextButton", Sidebar)
	TabBtn.Size = UDim2.new(0.9, 0, 0, 32)
	TabBtn.BackgroundColor3 = active and Color3.fromRGB(255, 215, 80) or Color3.fromRGB(25, 25, 35)
	TabBtn.Text = name
	TabBtn.TextColor3 = active and Color3.fromRGB(15, 15, 20) or Color3.fromRGB(200, 200, 210)
	TabBtn.Font = Enum.Font.GothamBold
	TabBtn.TextSize = 12
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

	local TabContent = Instance.new("ScrollingFrame", ContentContainer)
	TabContent.Size = UDim2.new(1, 0, 1, 0)
	TabContent.BackgroundTransparency = 1
	TabContent.Visible = active
	TabContent.ScrollBarThickness = 3
	TabContent.CanvasSize = UDim2.new(0, 0, 2, 0)

	local Layout = Instance.new("UIListLayout", TabContent)
	Layout.Padding = UDim.new(0, 8)

	Tabs[name] = {Btn = TabBtn, Content = TabContent}

	TabBtn.MouseButton1Click:Connect(function()
		for _, t in pairs(Tabs) do
			t.Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
			t.Btn.TextColor3 = Color3.fromRGB(200, 200, 210)
			t.Content.Visible = false
		end
		TabBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 80)
		TabBtn.TextColor3 = Color3.fromRGB(15, 15, 20)
		TabContent.Visible = true
	end)

	return TabContent
end

-- TẠO CÁC TAB KHUNG TRỐNG
local TabMain = CreateTab("Main", true)
local TabPlayer = CreateTab("Player", false)
local TabSettings = CreateTab("Settings", false)

-- ✨ HIỆU ỨNG MỞ/ĐÓNG MƯỢT MÀ (MỜ DẦN + PHÓNG TO NẸP)
local isOpen = true
local isBusy = false

Tog.MouseButton1Click:Connect(function()
	if isBusy then return end
	isBusy = true
	isOpen = not isOpen
	
	if isOpen then
		Main.Visible = true
		Main.BackgroundTransparency = 1
		Main.Size = UDim2.new(0, 550, 0, 300)
		Main.Position = UDim2.new(0.5, -275, 0.5, -150)
		
		TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.15,
			Size = UDim2.new(0, 580, 0, 320),
			Position = UDim2.new(0.5, -290, 0.5, -160)
		}):Play()
	else
		local t = TS:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 550, 0, 300),
			Position = UDim2.new(0.5, -275, 0.5, -150)
		})
		t:Play()
		t.Completed:Connect(function() Main.Visible = false end)
	end
	
	task.wait(0.3)
	isBusy = false
end)
