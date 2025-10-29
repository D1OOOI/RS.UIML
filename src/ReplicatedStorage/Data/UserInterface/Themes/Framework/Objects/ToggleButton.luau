local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

return {

	Extends = {
		Theme = "Framework",
		Object = "Label",
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
		end,

		ButtonState = function(self)
			local Attributes = self.Source.GuiObject:GetAttributes()

			local Layer2 = self.Source.GuiObject.Visual.Layer2

			if Attributes.State == true then
				for i, iObject in pairs({ "LeftUp-Down", "LeftUp-Right", "RightDown-Left", "RightDown-Up" }) do
					self.Utilities.Tween(Layer2[iObject], self.Utilities.TI(0.2), {
						BackgroundColor3 = Attributes.ActionColor,
					})
				end
			else
				for i, iObject in pairs({ "LeftUp-Down", "LeftUp-Right", "RightDown-Left", "RightDown-Up" }) do
					self.Utilities.Tween(Layer2[iObject], self.Utilities.TI(0.2), {
						BackgroundColor3 = Color3.new(1, 1, 1),
					})
				end
			end
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
		--     local Attributes = self.GuiObject:GetAttributes()
		-- end,
	},

	Tree = {
		{
			Path = "Interaction.Button",
			Functions = {
				Init = function(self)
					self.GuiObject.MouseButton1Click:Connect(function()
						self.Source.GuiObject:SetAttribute("State", not self.Source.GuiObject:GetAttribute("State"))

						self.Source.Object.Functions.ButtonState(self)
					end)
				end,
			},
		},
	},
}
