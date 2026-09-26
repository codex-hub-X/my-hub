local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LP:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("CodexUI_V8") then 
	PlayerGui.CodexUI_V8:Destroy() 
end

-- =================================================================
-- ⚙️ CÀI ĐẶT KIỂU HIỆU ỨNG MỞ / ĐÓNG MENU (ĐỔI SỐ TỪ 1 ĐẾN 5 TẠI ĐÂY)
-- 1: Flip3D | 2: PopOut | 3: SlideRight | 4: SlideUp | 5: Fade
local CURRENT_ANIMATION = 1 
-- =================================================================

local SG = Instance.new("ScreenGui", PlayerGui)
SG.Name = "CodexUI_V8"
SG.ResetOnSpawn = false

-- NÚT MỞ MENU TRÒN NỔI (TOGGLE BUTTON)
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

-- KHUNG CHÍNH (GLASSMORPHISM CARD V8)
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 390, 0, 490)
Main.Position = UDim2.new(0.5, -195, 0.5, -245)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Main.BackgroundTransparency = 0.2
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- Viền Vàng Kim Ánh Sáng Xoay (Glow Border)
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

local function CreateInput(parent, placeholder, isPassword)
	local boxFrame = Instance.new("Frame", parent)
	boxFrame.Size = UDim2.new(1, 0, 0, 40)
	boxFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	boxFrame.BackgroundTransparency = 0.3
	Instance.new("UICorner", boxFrame).CornerRadius = UDim.new(0, 10)
	
	local stroke = Instance.new("UIStroke", boxFrame)
	stroke.Color = Color3.fromRGB(45, 45, 55)
	stroke.Thickness = 1

	local input = Instance.new("TextBox", boxFrame)
	input.Size = UDim2.new(1, -20, 1, 0)
	input.Position = UDim2.new(0, 10, 0, 0)
	input.PlaceholderText = placeholder
	input.PlaceholderColor3 = Color3.fromRGB(110, 110, 125)
	input.Text = ""
	input.TextColor3 = Color3.fromRGB(245, 245, 255)
	input.Font = Enum.Font.GothamMedium
	input.TextSize = 12
	input.TextXAlignment = Enum.TextXAlignment.Left
	input.BackgroundTransparency = 1

	input.Focused:Connect(function()
		TS:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 215, 80)}):Play()
	end)
	input.FocusLost:Connect(function()
		TS:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 45, 55)}):Play()
	end)

	return boxFrame
end

-- TAB CONTROLLER
local PageSignIn = Instance.new("Frame", Main)
PageSignIn.Size = UDim2.new(1, -40, 1, -40)
PageSignIn.Position = UDim2.new(0, 20, 0, 20)
PageSignIn.BackgroundTransparency = 1

local Title1 = Instance.new("TextLabel", PageSignIn)
Title1.Size = UDim2.new(1, 0, 0, 32)
Title1.Text = "Welcome Back"
Title1.TextColor3 = Color3.fromRGB(255, 255, 255)
Title1.Font = Enum.Font.GothamBold
Title1.TextSize = 22
Title1.TextXAlignment = Enum.TextXAlignment.Left
Title1.BackgroundTransparency = 1

local Layout1 = Instance.new("UIListLayout", PageSignIn)
Layout1.Padding = UDim.new(0, 12)
Layout1.SortOrder = Enum.SortOrder.LayoutOrder

CreateInput(PageSignIn, "Username / Email").LayoutOrder = 1
CreateInput(PageSignIn, "Password", true).LayoutOrder = 2

local BtnSignIn = Instance.new("TextButton", PageSignIn)
BtnSignIn.Size = UDim2.new(1, 0, 0, 42)
BtnSignIn.BackgroundColor3 = Color3.fromRGB(255, 215, 80)
BtnSignIn.Text = "LOGIN NOW ➔"
BtnSignIn.TextColor3 = Color3.fromRGB(12, 12, 16)
BtnSignIn.Font = Enum.Font.GothamBold
BtnSignIn.TextSize = 13
BtnSignIn.LayoutOrder = 3
Instance.new("UICorner", BtnSignIn).CornerRadius = UDim.new(0, 10)

-- HỆ THỐNG HIỆU ỨNG MỞ/ĐÓNG (ANIMATIONS)
local isOpen = true
local isBusy = false

local function OpenMenu()
	Main.Visible = true
	if CURRENT_ANIMATION == 1 then -- Flip 3D
		Main.Size = UDim2.new(0, 0, 0, 490)
		Main.Position = UDim2.new(0.5, 0, 0.5, -245)
		TS:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 390, 0, 490),
			Position = UDim2.new(0.5, -195, 0.5, -245)
		}):Play()
	elseif CURRENT_ANIMATION == 2 then -- PopOut
		Main.Size = UDim2.new(0, 0, 0, 0)
		Main.Position = UDim2.new(0.5, 0, 0.5, 0)
		TS:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 390, 0, 490),
			Position = UDim2.new(0.5, -195, 0.5, -245)
		}):Play()
	elseif CURRENT_ANIMATION == 3 then -- Slide Right
		Main.Position = UDim2.new(0, -400, 0.5, -245)
		TS:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, -195, 0.5, -245)
		}):Play()
	elseif CURRENT_ANIMATION == 4 then -- Slide Up
		Main.Position = UDim2.new(0.5, -195, 1, 50)
		TS:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, -195, 0.5, -245)
		}):Play()
	elseif CURRENT_ANIMATION == 5 then -- Fade
		Main.BackgroundTransparency = 1
		TS:Create(Main, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
	end
end

local function CloseMenu()
	if CURRENT_ANIMATION == 1 then -- Flip 3D
		local t = TS:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 490),
			Position = UDim2.new(0.5, 0, 0.5, -245)
		})
		t:Play()
		t.Completed:Connect(function() Main.Visible = false end)
	elseif CURRENT_ANIMATION == 2 then -- PopOut
		local t = TS:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})
		t:Play()
		t.Completed:Connect(function() Main.Visible = false end)
	elseif CURRENT_ANIMATION == 3 then -- Slide Right
		local t = TS:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(0, -400, 0.5, -245)
		})
		t:Play()
		t.Completed:Connect(function() Main.Visible = false end)
	elseif CURRENT_ANIMATION == 4 then -- Slide Up
		local t = TS:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(0.5, -195, 1, 50)
		})
		t:Play()
		t.Completed:Connect(function() Main.Visible = false end)
	elseif CURRENT_ANIMATION == 5 then -- Fade
		local t = TS:Create(Main, TweenInfo.new(0.25), {BackgroundTransparency = 1})
		t:Play()
		t.Completed:Connect(function() Main.Visible = false end)
	end
end

Tog.MouseButton1Click:Connect(function()
	if isBusy then return end
	isBusy = true
	isOpen = not isOpen
	if isOpen then OpenMenu() else CloseMenu() end
	task.wait(0.3)
	isBusy = false
end)

