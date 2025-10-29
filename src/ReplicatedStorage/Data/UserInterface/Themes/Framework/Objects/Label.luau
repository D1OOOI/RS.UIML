local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

return {

	Extends = {
		Theme = "Framework",
		Object = "Frame",
	},

	Properties = {},

	Attributes = {},

	Tags = {},

	Functions = {
		Init = function(self)
			local Attributes = self.GuiObject:GetAttributes()

			self.Object.Functions.Connect(self)
			self.Object.Functions.Start(self)
			self.Object.Functions.Update(self)

			self.Utilities.CreateUIComponents(self.GuiObject)

			--------------------------------------------------
		end,

		Start = function(self)
			local Attributes = self.GuiObject:GetAttributes()
		end,

		Connect = function(self)
			self.GuiObject.AttributeChanged:Connect(function()
				self.Object.Functions.Update(self)
			end)
		end,

		Update = function(self)
			local Attributes = self.GuiObject:GetAttributes()

			local Interaction = self.Source.GuiObject.Interaction

			Interaction.TextLabel.Text = Attributes.Text
			Interaction.TextLabelShadow.Text = Attributes.Text

			Interaction.ImageLabel.Image = Attributes.Image
			Interaction.ImageLabelShadow.Image = Attributes.Image

			self.GuiObject.Interaction.TextLabel.TextColor3 = Attributes.TextColor
			self.GuiObject.Interaction.TextLabel.UIStroke.Color = Attributes.TextShadowColor
			self.GuiObject.Interaction.TextLabelShadow.TextColor3 = Attributes.ActionColor
			self.GuiObject.Interaction.TextLabelShadow.UIStroke.Color = Attributes.ActionColor
			self.GuiObject.Interaction.ImageLabelShadow.ImageColor3 = Attributes.ActionColor
		end,
	},

	GuiState = {
		-- NonInteractable = function(self)
		--     local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Idle = function(self)
		--     local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Hover = function(self)
		--     local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Press = function(self)
		--     local Attributes = self.GuiObject:GetAttributes()
		-- end,
	},

	Tree = {},
}
