local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LP:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("VideoStyleUI") then 
	PlayerGui.VideoStyleUI:Destroy() 
end

local SG = Instance.new("ScreenGui", PlayerGui)
SG.Name = "VideoStyleUI"
SG.ResetOnSpawn = false

local Library = {}

function Library:CreateWindow(hubTitle)
	-- Nút Floating Toggle (Tròn phát sáng)
	local Tog = Instance.new("TextButton", SG)
	Tog.Size = UDim2.new(0, 46, 0, 46)
	Tog.Position = UDim2.new(0, 20, 0.45, 0)
	Tog.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Tog.BackgroundTransparency = 0.2
	Tog.Text = "⚡"
	Tog.TextColor3 = Color3.fromRGB(255, 190, 60)
	Tog.TextSize = 20
	Tog.Draggable = true
	Tog.Active = true
	Instance.new("UICorner", Tog).CornerRadius = UDim.new(1, 0)
	
	local TogStroke = Instance.new("UIStroke", Tog)
	TogStroke.Color = Color3.fromRGB(255, 190, 60)
	TogStroke.Thickness = 1.5

	-- KHUNG MAIN TRONG SUỐT (GLASSMORPHISM EFFECT)
	local Main = Instance.new("Frame", SG)
	Main.Size = UDim2.new(0, 420, 0, 320)
	Main.Position = UDim2.new(0.5, -210, 0.5, -160)
	Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
	Main.BackgroundTransparency = 0.25 -- Độ trong suốt kính mờ
	Main.Active = true
	Main.Draggable = true
	Main.ClipsDescendants = true
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

	-- Viền Gradient Đèn Neon Xoay (Glow Animated Border)
	local MainStroke = Instance.new("UIStroke", Main)
	MainStroke.Thickness = 1.8
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	
	local Gradient = Instance.new("UIGradient", MainStroke)
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 80)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 50, 10)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 80))
	})
	
	-- Animation xoay viền sáng liên tục
	RunService.RenderStepped:Connect(function()
		Gradient.Rotation = (Gradient.Rotation + 1) % 360
	end)

	-- Title Bar
	local Title = Instance.new("TextLabel", Main)
	Title.Size = UDim2.new(1, 0, 0, 45)
	Title.Text = hubTitle or "MAIN MENU"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.BackgroundTransparency = 1

	-- Page Holder
	local PageHolder = Instance.new("Frame", Main)
	PageHolder.Size = UDim2.new(1, -40, 1, -95)
	PageHolder.Position = UDim2.new(0, 20, 0, 45)
	PageHolder.BackgroundTransparency = 1

	local T1 = Instance.new("ScrollingFrame", PageHolder)
	T1.Size = UDim2.new(1, 0, 1, 0)
	T1.BackgroundTransparency = 1
	T1.ScrollBarThickness = 2
	T1.ScrollBarImageColor3 = Color3.fromRGB(255, 190, 60)
	T1.Visible = true
	Instance.new("UIListLayout", T1).Padding = UDim.new(0, 8)

	local T2 = Instance.new("ScrollingFrame", PageHolder)
	T2.Size = UDim2.new(1, 0, 1, 0)
	T2.BackgroundTransparency = 1
	T2.ScrollBarThickness = 2
	T2.ScrollBarImageColor3 = Color3.fromRGB(255, 190, 60)
	T2.Visible = false
	Instance.new("UIListLayout", T2).Padding = UDim.new(0, 8)

	-- Switch Tab Button (Animation Lật Card 3D)
	local Sw = Instance.new("TextButton", Main)
	Sw.Size = UDim2.new(1, -40, 0, 30)
	Sw.Position = UDim2.new(0, 20, 1, -38)
	Sw.Text = "Don't have an account? Sign Up"
	Sw.TextColor3 = Color3.fromRGB(170, 170, 180)
	Sw.Font = Enum.Font.Gotham
	Sw.TextSize = 12
	Sw.BackgroundTransparency = 1

	local isT1, anim = true, false
	Sw.MouseButton1Click:Connect(function()
		if anim then return end
		anim = true

		-- Animation Thu Hẹp Lật Khung
		TS:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 320),
			Position = UDim2.new(0.5, 0, 0.5, -160)
		}):Play()

		task.wait(0.2)
		isT1 = not isT1
		T1.Visible = isT1
		T2.Visible = not isT1
		Title.Text = isT1 and hubTitle or "SETTINGS & EXTRA"
		Sw.Text = isT1 and "Don't have an account? Sign Up" or "Already have an account? Login"

		-- Animation Nảy Khung Mở Ra (Back/Elastic)
		TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 420, 0, 320),
			Position = UDim2.new(0.5, -210, 0.5, -160)
		}):Play()

		task.wait(0.3)
		anim = false
	end)

	-- Bật / Tắt UI Animation
	local vis = true
	local function ToggleUI()
		vis = not vis
		if vis then
			Main.Visible = true
			TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 420, 0, 320),
				Position = UDim2.new(0.5, -210, 0.5, -160)
			}):Play()
		else
			local t = TS:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0)
			})
			t:Play()
			t.Completed:Connect(function() Main.Visible = false end)
		end
	end

	Tog.MouseButton1Click:Connect(ToggleUI)
	UIS.InputBegan:Connect(function(i, g)
		if not g and i.KeyCode == Enum.KeyCode.RightControl then ToggleUI() end
	end)

	-- Notification Trong Suốt Mượt
	function Library:Notify(m)
		local n = Instance.new("Frame", SG)
		n.Size = UDim2.new(0, 210, 0, 36)
		n.Position = UDim2.new(1, 10, 0.85, 0)
		n.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
		n.BackgroundTransparency = 0.2
		Instance.new("UICorner", n).CornerRadius = UDim.new(0, 8)
		local s = Instance.new("UIStroke", n)
		s.Color = Color3.fromRGB(255, 190, 60)
		s.Thickness = 1.2

		local l = Instance.new("TextLabel", n)
		l.Size = UDim2.new(1, 0, 1, 0)
		l.Text = m
		l.TextColor3 = Color3.fromRGB(240, 240, 240)
		l.Font = Enum.Font.GothamMedium
		l.BackgroundTransparency = 1
		l.TextSize = 11

		TS:Create(n, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(1, -230, 0.85, 0)}):Play()
		task.delay(2.2, function()
			local t = TS:Create(n, TweenInfo.new(0.2), {Position = UDim2.new(1, 10, 0.85, 0)})
			t:Play()
			t.Completed:Connect(function() n:Destroy() end)
		end)
	end

	-- Component Trong Suốt Mượt
	local Win = {}
	function Win:AddButton(p, t, cb)
		local b = Instance.new("TextButton", p)
		b.Size = UDim2.new(1, 0, 0, 36)
		b.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
		b.BackgroundTransparency = 0.3
		b.Text = t
		b.TextColor3 = Color3.fromRGB(240, 240, 250)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 12
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

		-- Animation Hover
		b.MouseEnter:Connect(function()
			TS:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(255, 190, 60), TextColor3 = Color3.fromRGB(10, 10, 15)}):Play()
		end)
		b.MouseLeave:Connect(function()
			TS:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.3, BackgroundColor3 = Color3.fromRGB(25, 25, 32), TextColor3 = Color3.fromRGB(240, 240, 250)}):Play()
		end)
		b.MouseButton1Click:Connect(function() if cb then cb() end end)
	end

	function Win:AddToggle(p, t, cb)
		local f = Instance.new("Frame", p)
		f.Size = UDim2.new(1, 0, 0, 36)
		f.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
		f.BackgroundTransparency = 0.3
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

		local l = Instance.new("TextLabel", f)
		l.Size = UDim2.new(0.7, 0, 1, 0)
		l.Position = UDim2.new(0, 12, 0, 0)
		l.Text = t
		l.TextColor3 = Color3.fromRGB(240, 240, 250)
		l.Font = Enum.Font.Gotham
		l.TextSize = 12
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.BackgroundTransparency = 1

		local b = Instance.new("TextButton", f)
		b.Size = UDim2.new(0, 40, 0, 20)
		b.Position = UDim2.new(1, -50, 0.5, -10)
		b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		b.Text = ""
		Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

		local d = Instance.new("Frame", b)
		d.Size = UDim2.new(0, 16, 0, 16)
		d.Position = UDim2.new(0, 2, 0.5, -8)
		d.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
		Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)

		local on = false
		b.MouseButton1Click:Connect(function()
			on = not on
			-- Animation Toggle Nảy Smooth
			TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = on and Color3.fromRGB(255, 190, 60) or Color3.fromRGB(40, 40, 50)}):Play()
			TS:Create(d, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = on and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = on and Color3.fromRGB(10, 10, 15) or Color3.fromRGB(180, 180, 190)}):Play()
			if cb then cb(on) end
		end)
	end

	return Win, T1, T2
end

-- KÍCH HOẠT MENU
local UI, Tab1, Tab2 = Library:CreateWindow("WELCOME BACK")

UI:AddButton(Tab1, "Auto Farm Level", function()
	Library:Notify("Đã bật Auto Farm!")
end)

UI:AddToggle(Tab1, "Kill Aura (Fast)", function(state)
	Library:Notify("Kill Aura: " .. tostring(state))
end)

UI:AddToggle(Tab2, "Infinite Jump", function(state)
	Library:Notify("Inf Jump: " .. tostring(state))
end)
