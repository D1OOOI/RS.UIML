local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

return {

	--Extends = {
	--	Theme = nil,
	--	Object = nil,
	--},

	Properties = {},

	Attributes = {},

	Tags = {},

	Functions = {
		Init = function(self)
			local Attributes = self.GuiObject:GetAttributes()

			self.Object.Functions.Connect(self)
			self.Object.Functions.Start(self)
			self.Object.Functions.Update(self)

			for i = 2, 10 do
				local Layer = self.GuiObject.Visual.Layer1:Clone()

				Layer.Name = `Layer{i}`
				Layer.ZIndex = i

				Layer.Parent = self.GuiObject.Visual
			end
		end,

		Start = function(self)
			local Attributes = self.GuiObject:GetAttributes()

			self.Utilities.CreateUIComponents(self.GuiObject)
			self.Utilities.UpdateChangeables(self.GuiObject)
		end,

		Connect = function(self)
			self.GuiObject.AttributeChanged:Connect(function()
				self.Object.Functions.Update(self)
			end)
		end,

		Update = function(self)
			local Attributes = self.GuiObject:GetAttributes()

			self.Utilities.UpdateChangeables(self.GuiObject)
		end,
	},

	GuiState = {
		-- NonInteractable = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Idle = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Hover = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Press = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,
	},

	Tree = {
		{
			ClassName = "Frame",
			Properties = {
				Name = "Interaction",

				BackgroundTransparency = 1,

				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(1, 1),

				ZIndex = 1000,
			},
			Tree = {
				{
					ClassName = "TextButton",
					Properties = {
						Name = "Button",

						BackgroundTransparency = 1,

						Size = UDim2.fromScale(1, 1),

						ZIndex = 1000,

						Text = "",
						TextSize = 1,
					},
				},

				{
					ClassName = "TextBox",
					Properties = {
						Name = "TextBox",

						Interactable = false,

						BackgroundTransparency = 1,

						Size = UDim2.fromScale(1, 1),

						ZIndex = 100,

						ClearTextOnFocus = false,

						Text = "",
						TextSize = 1,
					},
				},

				{
					ClassName = "ViewportFrame",
					Properties = {
						Ambient = game:GetService("Lighting").Ambient,

						ZIndex = -100,
					},
					Tree = {
						{
							ClassName = "Folder",
							Properties = {
								Name = "Objects",
							},
						},
					},
				},

				{
					ClassName = "TextLabel",
					Properties = {
						BackgroundTransparency = 1,

						Position = UDim2.fromOffset(0, 0),
						Size = UDim2.fromScale(1, 1),

						ZIndex = 10,

						FontFace = Font.fromId(12187365364, Enum.FontWeight.Bold),

						Text = "",

						TextScaled = true,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
					},
					Tree = {
						{
							ClassName = "UITextSizeConstraint",
							Properties = {
								MaxTextSize = 20,
								MinTextSize = 5,
							},
						},
						{
							ClassName = "UIStroke",
							Properties = {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
								Thickness = 2,
							},
						},
					},
				},

				{
					ClassName = "TextLabel",
					Properties = {
						Name = "TextLabelShadow",

						BackgroundTransparency = 1,

						Position = UDim2.fromOffset(0, 0),
						Size = UDim2.fromScale(1, 1),

						ZIndex = -10,

						FontFace = Font.fromId(12187365364, Enum.FontWeight.Bold),

						Text = "",

						TextScaled = true,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
					},
					Tree = {
						{
							ClassName = "UITextSizeConstraint",
							Properties = {
								MaxTextSize = 20,
								MinTextSize = 5,
							},
						},
						{
							ClassName = "UIStroke",
							Properties = {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
								Thickness = 2,
							},
						},
					},
				},

				{
					ClassName = "ImageLabel",
					Properties = {
						BackgroundTransparency = 1,

						Position = UDim2.fromOffset(0, -1),
						Size = UDim2.fromScale(1, 1),

						ZIndex = 10,

						Image = "",
					},
				},

				{
					ClassName = "ImageLabel",
					Properties = {
						Name = "ImageLabelShadow",

						BackgroundTransparency = 1,

						Position = UDim2.fromOffset(0, 1),
						Size = UDim2.fromScale(1, 1),

						ZIndex = -10,

						Image = "",
					},
				},
			},
		},

		{
			ClassName = "Folder",
			Properties = {
				Name = "Visual",
			},
			Tree = {
				{
					ClassName = "Frame",
					Properties = {
						Name = "Layer1",

						BackgroundTransparency = 1,

						Size = UDim2.fromScale(1, 1),

						ZIndex = 1,
					},
				},
			},
		},
	},
}
