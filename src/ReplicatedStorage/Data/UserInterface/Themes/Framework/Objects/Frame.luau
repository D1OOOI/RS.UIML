local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local Utilities = require(script.Parent.Parent.Parent.__Utilities)

return {

	Extends = {
		Theme = "Core",
		Object = "Structure",
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
		end,

		CreateTouch = function(
			self,
			Object: GuiObject,
			SourceSelf,
			SourceObject: GuiObject,
			TouchObject: GuiObject,
			MainColor: Color3,
			ShadowColor: Color3,
			DecreaseEvent
		)
			local Assets = SourceObject.Assets
			local TouchAnim = Assets.Touch:Clone()

			TouchAnim.Touch1.BackgroundColor3 = MainColor or Color3.new(1, 1, 1)
			TouchAnim.Touch2.BackgroundColor3 = ShadowColor or Color3.new(0, 0, 0)

			TouchAnim.Parent = TouchObject

			if TouchObject:GetAttribute("LastMouseLocation") ~= nil then
				TouchAnim.Position = TouchObject:GetAttribute("LastMouseLocation")
			end

			local Connected = TouchObject:GetAttribute("IsConnected.MouseMoved")

			if Connected ~= true then
				TouchObject.MouseMoved:Connect(function(X, Y)
					TouchObject:SetAttribute(
						"LastMouseLocation",
						UDim2.fromOffset(X - TouchObject.AbsolutePosition.X, Y - TouchObject.AbsolutePosition.Y)
					)
				end)
				TouchObject:SetAttribute("IsConnected.MouseMoved", true)
			end

			Utilities.Tween(TouchAnim.Touch1, Utilities.TI(0.5), {
				BackgroundTransparency = 0.5,
				Size = UDim2.fromScale(5, 5),
			})
			Utilities.Tween(TouchAnim.Touch2, Utilities.TI(0.5, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 0,
				Size = UDim2.fromScale(5, 5),
			})

			if DecreaseEvent == nil then
				task.wait(0.5)
				Utilities.Tween(TouchAnim.Touch1, Utilities.TI(0.5), {
					BackgroundTransparency = 1,
				})
				Utilities.Tween(TouchAnim.Touch2, Utilities.TI(1), {
					BackgroundTransparency = 1,
				})
				task.wait(0.5)
				TouchAnim:Destroy()
			else
				local Connection = nil

				Connection = DecreaseEvent:Connect(function()
					Utilities.Tween(TouchAnim.Touch1, Utilities.TI(0.5), {
						BackgroundTransparency = 1,
					})
					Utilities.Tween(TouchAnim.Touch2, Utilities.TI(0.5), {
						BackgroundTransparency = 1,
					})
					task.wait(0.5)
					TouchAnim:Destroy()

					Connection:Disconnect()
				end)
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

		Press = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
			local Attributes = Object:GetAttributes()

			local AnimLayer1 = Object.Visual.AnimationLayer1

			self.Functions.CreateTouch(self, Object, AnimLayer1)
		end,
	},

	Tree = {
		{
			Path = "Interaction.Button",
			GuiState = {
				Press = function(self, Object: GuiObject, SourceSelf, SourceObject: GuiObject)
					local Attributes = Object:GetAttributes()

					local AnimLayer1 = SourceObject.Visual.AnimationLayer1

					SourceSelf.Functions.CreateTouch(self, Object, SourceSelf, SourceObject, AnimLayer1)
				end,
			},
		},
		{
			Path = "Visual.Layer1",
			Tree = {
				{
					ClassName = "Frame",
					Properties = {
						BackgroundColor3 = Color3.new(0.05, 0.05, 0.05),
						Size = UDim2.fromScale(1, 1),
					},
				},
			},
		},
		{
			Path = "Visual.Layer2",
			Tree = {
				{
					Path = "UIPadding",
					Properties = {
						PaddingBottom = UDim.new(0, 5),
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 5),
					},
				},
				{
					ClassName = "Frame",
					Properties = {
						Name = "LeftUp-Right",

						BackgroundColor3 = Color3.new(1, 1, 1),
						Size = UDim2.fromOffset(25, 5),
					},
				},
				{
					ClassName = "Frame",
					Properties = {
						Name = "LeftUp-Down",

						BackgroundColor3 = Color3.new(1, 1, 1),
						Size = UDim2.fromOffset(5, 25),
					},
				},
				{
					ClassName = "Frame",
					Properties = {
						Name = "RightDown-Left",

						BackgroundColor3 = Color3.new(1, 1, 1),
						AnchorPoint = Vector2.new(1, 1),
						Position = UDim2.fromScale(1, 1),
						Size = UDim2.fromOffset(25, 5),
					},
				},
				{
					ClassName = "Frame",
					Properties = {
						Name = "RightDown-Up",

						BackgroundColor3 = Color3.new(1, 1, 1),
						AnchorPoint = Vector2.new(1, 1),
						Position = UDim2.fromScale(1, 1),
						Size = UDim2.fromOffset(5, 25),
					},
				},
			},
		},
		{
			Path = "Visual",
			Tree = {
				{
					ClassName = "CanvasGroup",
					Properties = {
						Name = "AnimationLayer1",

						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 1,
					},
					Tree = {},
				},
			},
		},
		{
			ClassName = "Model",
			Properties = {
				Name = "Assets",
			},
			Tree = {
				{
					ClassName = "Frame",
					Properties = {
						Name = "Touch",

						BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromScale(1, 1),
					},
					Tree = {
						{
							ClassName = "Frame",
							Properties = {
								Name = "Touch1",

								ZIndex = 1,

								BackgroundColor3 = Color3.new(1, 1, 1),
								BackgroundTransparency = 1,
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(0.5, 0.5),
							},
							Tree = {
								{
									ClassName = "UIAspectRatioConstraint",
								},
								{
									ClassName = "UICorner",
									Properties = {
										CornerRadius = UDim.new(1, 1),
									},
								},
							},
						},
						{
							ClassName = "Frame",
							Properties = {
								Name = "Touch2",

								ZIndex = 2,

								BackgroundColor3 = Color3.new(0, 0, 0),
								BackgroundTransparency = 1,
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(0, 0),
							},
							Tree = {
								{
									ClassName = "UIAspectRatioConstraint",
								},
								{
									ClassName = "UICorner",
									Properties = {
										CornerRadius = UDim.new(1, 1),
									},
								},
							},
						},
					},
				},
			},
		},
	},
}
