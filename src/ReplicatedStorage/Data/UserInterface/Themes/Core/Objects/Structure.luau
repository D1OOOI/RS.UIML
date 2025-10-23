local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local Utilities = require(script.Parent.Parent.Parent.__Utilities)

return {

	--Extends = {
	--	Theme = nil,
	--	Object = nil,
	--},

	Properties = {},

	Attributes = {},

	Tags = {},

	Functions = {
		Init = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = Object:GetAttributes()

			self.Functions.Connect(self, Object, SourceSelf, SourceObject)
			self.Functions.Start(self, Object, SourceSelf, SourceObject)
			self.Functions.Update(self, Object, SourceSelf, SourceObject)

			Utilities.CreateUIComponents(Object)

			for i = 2, 10 do
				local Layer = Object.Visual.Layer1:Clone()

				Layer.Name = `Layer{i}`
				Layer.ZIndex = i

				Layer.Parent = Object.Visual
			end
		end,

		Start = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = Object:GetAttributes()

			Utilities.UpdateChangeables(Object)
		end,

		Connect = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			Object.AttributeChanged:Connect(function()
				self.Functions.Update(self, Object, SourceSelf, SourceObject)
			end)
		end,

		Update = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = Object:GetAttributes()
		end,
	},

	GuiState = {
		--NonInteractable = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
		--	local Attributes = Object:GetAttributes()
		--end,

		--Idle = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
		--	local Attributes = Object:GetAttributes()
		--end,

		--Hover = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
		--	local Attributes = Object:GetAttributes()
		--end,

		--Press = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
		--	local Attributes = Object:GetAttributes()
		--end,
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
