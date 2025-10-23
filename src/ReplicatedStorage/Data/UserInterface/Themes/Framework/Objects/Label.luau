local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local Utilities = require(script.Parent.Parent.Parent.__Utilities)

return {

	Extends = {
		Theme = "Framework",
		Object = "Frame",
	},

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

			--------------------------------------------------
		end,

		Start = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = Object:GetAttributes()
		end,

		Connect = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			Object.AttributeChanged:Connect(function()
				self.Functions.Update(self, Object, SourceSelf, SourceObject)
			end)
		end,

		Update = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = Object:GetAttributes()

			local Interaction = SourceObject.Interaction

			Interaction.TextLabel.Text = Attributes.Text
			Interaction.TextLabelShadow.Text = Attributes.Text

			Interaction.ImageLabel.Image = Attributes.Image
			Interaction.ImageLabelShadow.Image = Attributes.Image

			Object.Interaction.TextLabel.TextColor3 = Attributes.TextColor
			Object.Interaction.TextLabel.UIStroke.Color = Attributes.TextShadowColor
			Object.Interaction.TextLabelShadow.TextColor3 = Attributes.Color2
			Object.Interaction.TextLabelShadow.UIStroke.Color = Attributes.Color2
			Object.Interaction.ImageLabelShadow.ImageColor3 = Attributes.Color2
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

	Tree = {},
}
