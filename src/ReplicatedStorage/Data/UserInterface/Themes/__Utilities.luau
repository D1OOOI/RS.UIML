local TS = game:GetService("TweenService")

return {
	AddColors3 = function(c1: Color3, c2: Color3)
		return Color3.new(math.clamp(c1.R + c2.R, 0, 1), math.clamp(c1.G + c2.G, 0, 1), math.clamp(c1.B + c2.B, 0, 1))
	end,

	SubtractColors3 = function(c1: Color3, c2: Color3)
		return Color3.new(math.clamp(c1.R - c2.R, 0, 1), math.clamp(c1.G - c2.G, 0, 1), math.clamp(c1.B - c2.B, 0, 1))
	end,

	MultiplyColor3 = function(c1: Color3, Multiplier: number)
		return Color3.new(
			math.clamp(c1.R * Multiplier, 0, 1),
			math.clamp(c1.G * Multiplier, 0, 1),
			math.clamp(c1.B * Multiplier, 0, 1)
		)
	end,

	Tween = function(_Instance: Instance, _TI: TweenInfo, Properties)
		local Tween = TS:Create(_Instance, _TI, Properties)

		Tween:Play()

		return Tween
	end,

	TI = function(
		Time: number,
		EasingStyle: Enum.EasingStyle,
		EasingDirection: Enum.EasingDirection,
		RepeatCount: number,
		Reverse: boolean,
		DelayTime: number
	): TweenInfo
		return TweenInfo.new(
			Time or 1,
			EasingStyle or Enum.EasingStyle.Linear,
			EasingDirection or Enum.EasingDirection.In,
			RepeatCount or 0,
			Reverse or false,
			DelayTime or 0
		)
	end,

	UpdateChangeables = function(GuiObject: GuiObject)
		local Attributes = GuiObject:GetAttributes()

		for _i, iObject in pairs(GuiObject:GetDescendants()) do
			if iObject:IsA("UICorner") then
				if iObject:GetAttribute("Changeable") == true then
					iObject.CornerRadius = Attributes.UICornerRadius
				end
			end
		end
	end,

	CreateUIComponents = function(GuiObject: GuiObject)
		local GuiObjects = GuiObject:GetDescendants()

		table.insert(GuiObjects, GuiObject)

		for i, iObject in pairs(GuiObjects) do
			if iObject:IsA("GuiObject") == false then
				continue
			end

			local Corner: UICorner = iObject:FindFirstChildWhichIsA("UICorner")
			local Padding: UIPadding = iObject:FindFirstChildWhichIsA("UIPadding")
			local Stroke: UIStroke = iObject:FindFirstChildWhichIsA("UIStroke")

			if Corner == nil then
				Corner = Instance.new("UICorner")

				Corner.Name = "UICorner"
				Corner.CornerRadius = UDim.new(0, 0)

				Corner:SetAttribute("Changeable", true)

				Corner.Parent = iObject
			end

			if Padding == nil then
				Padding = Instance.new("UIPadding")

				Padding.Name = "UIPadding"

				Padding:SetAttribute("Changeable", true)

				Padding.Parent = iObject
			end

			if Stroke == nil then
				Stroke = Instance.new("UIStroke")

				Stroke.Name = "UIStroke"
				Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Stroke.Thickness = 0

				Stroke:SetAttribute("Changeable", true)

				Stroke.Parent = iObject
			end
		end
	end,
}
