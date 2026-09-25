local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Custom Hub",
   LoadingTitle = "Đang tải...",
   LoadingSubtitle = "",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false -- Đã tắt hoàn toàn Key System
})

---------------------------------------------------------
-- CÁC TAB CHỨC NĂNG
---------------------------------------------------------
local MovementTab = Window:CreateTab("Di Chuyển")
local VisualTab   = Window:CreateTab("Hiển Thị")
local CombatTab   = Window:CreateTab("Chiến Đấu")

---------------------------------------------------------
-- 1. TAB DI CHUYỂN
---------------------------------------------------------
MovementTab:CreateSlider({
   Name = "Tốc Độ Di Chuyển",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      pcall(function()
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = Value
         end
      end)
   end,
})

MovementTab:CreateSlider({
   Name = "Sức Nhảy",
   Range = {50, 500},
   Increment = 5,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      pcall(function()
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.UseJumpPower = true
            char.Humanoid.JumpPower = Value
         end
      end)
   end,
})

MovementTab:CreateToggle({
   Name = "Nhảy Vô Hạn",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
      _G.InfJump = Value
   end,
})

MovementTab:CreateToggle({
   Name = "Đi Xuyên Tường (Noclip)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      _G.Noclip = Value
   end,
})

MovementTab:CreateToggle({
   Name = "Bay (Fly - Giữ Nút Nhảy)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      _G.FlyEnabled = Value
   end,
})

---------------------------------------------------------
-- 2. TAB HIỂN THỊ
---------------------------------------------------------
VisualTab:CreateToggle({
   Name = "Nhìn Xuyên Tường (ESP)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      _G.PlayerESP = Value
      if not Value then
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Highlight") then
               player.Character.Highlight:Destroy()
            end
         end
      end
   end,
})

VisualTab:CreateToggle({
   Name = "Bật Sáng Tối Đa (Fullbright)",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
      if Value then
         game:GetService("Lighting").Brightness = 2
         game:GetService("Lighting").ClockTime = 14
         game:GetService("Lighting").FogEnd = 100000
         game:GetService("Lighting").GlobalShadows = false
      else
         game:GetService("Lighting").Brightness = 1
         game:GetService("Lighting").GlobalShadows = true
      end
   end,
})

---------------------------------------------------------
-- 3. TAB CHIẾN ĐẤU
---------------------------------------------------------
CombatTab:CreateToggle({
   Name = "Chống Văng (Anti-Fling)",
   CurrentValue = false,
   Flag = "AntiFlingToggle",
   Callback = function(Value)
      _G.AntiFling = Value
   end,
})

CombatTab:CreateButton({
   Name = "Reset Nhân Vật",
   Callback = function()
      pcall(function()
         game.Players.LocalPlayer.Character:BreakJoints()
      end)
   end,
})

CombatTab:CreateButton({
   Name = "Dịch Chuyển Tới Người Chơi Ngẫu Nhiên",
   Callback = function()
      local players = game.Players:GetPlayers()
      local randomPlayer = players[math.random(1, #players)]
      if randomPlayer and randomPlayer ~= game.Players.LocalPlayer and randomPlayer.Character then
         pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
         end)
      end
   end,
})

---------------------------------------------------------
-- LOGIC HỆ THỐNG (RUNSERVICE)
---------------------------------------------------------
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

UserInputService.JumpRequest:Connect(function()
   if _G.InfJump then
      pcall(function()
         game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
      end)
   end
end)

RunService.Stepped:Connect(function()
   local localPlayer = game.Players.LocalPlayer
   local char = localPlayer.Character

   if _G.Noclip and char then
      for _, part in pairs(char:GetDescendants()) do
         if part:IsA("BasePart") then
            part.CanCollide = false
         end
      end
   end

   if _G.AntiFling then
      pcall(function()
         for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
               for _, part in pairs(player.Character:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
            end
         end
      end)
   end

   if _G.FlyEnabled and char and char:FindFirstChild("HumanoidRootPart") then
      pcall(function()
         if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, 50, char.HumanoidRootPart.Velocity.Z)
         end
      end)
   end

   if _G.PlayerESP then
      pcall(function()
         for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and not player.Character:FindFirstChild("Highlight") then
               local highlight = Instance.new("Highlight")
               highlight.Name = "Highlight"
               highlight.FillColor = Color3.fromRGB(255, 0, 0)
               highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
               highlight.FillTransparency = 0.5
               highlight.Parent = player.Character
            end
         end
      end)
   end
end)
