local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

return {

	Extends = {
		Theme = "Core",
		Object = "Structure",
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

	Tree = {},
}
