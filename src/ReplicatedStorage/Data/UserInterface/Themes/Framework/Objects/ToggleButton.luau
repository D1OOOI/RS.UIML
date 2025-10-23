local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local Utilities = require(script.Parent.Parent.Parent.__Utilities)

return {

	Extends = {
		Theme = "Framework",
		Object = "Label",
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
		end,

		ButtonState = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = SourceObject:GetAttributes()

			local Layer2 = SourceObject.Visual.Layer2

			if Attributes.State == true then
				for i, iObject in pairs({ "LeftUp-Down", "LeftUp-Right", "RightDown-Left", "RightDown-Up" }) do
					Utilities.Tween(Layer2[iObject], Utilities.TI(0.2), {
						BackgroundColor3 = Attributes.Color2,
					})
				end
			else
				for i, iObject in pairs({ "LeftUp-Down", "LeftUp-Right", "RightDown-Left", "RightDown-Up" }) do
					Utilities.Tween(Layer2[iObject], Utilities.TI(0.2), {
						BackgroundColor3 = Color3.new(1, 1, 1),
					})
				end
			end
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
			Path = "Interaction.Button",
			Functions = {
				Init = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
					Object.MouseButton1Click:Connect(function()
						SourceObject:SetAttribute("State", not SourceObject:GetAttribute("State"))

						SourceSelf.Functions.ButtonState(self, Object, SourceSelf, SourceObject)
					end)
				end,
			},
		},
	},
}
