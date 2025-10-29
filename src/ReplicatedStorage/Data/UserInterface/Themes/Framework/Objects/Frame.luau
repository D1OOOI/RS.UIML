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
			self.Utilities.UpdateChangeables(self.GuiObject)

			--------------------------------------------------
			local AnimLayer1 = self.GuiObject.Visual.AnimationLayer1

			self.Object.Functions.ConnectTouch(self, AnimLayer1)
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

		ConnectTouch = function(self, TouchObject: GuiObject)
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
		end,

		CreateTouch = function(self, TouchObject: GuiObject, MainColor: Color3, ShadowColor: Color3, DecreaseEvent)
			local Assets = self.Source.GuiObject.Assets
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

			self.Utilities.Tween(TouchAnim.Touch1, self.Utilities.TI(0.5), {
				BackgroundTransparency = 0.5,
				Size = UDim2.fromScale(5, 5),
			})
			self.Utilities.Tween(TouchAnim.Touch2, self.Utilities.TI(0.5, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 0,
				Size = UDim2.fromScale(5, 5),
			})

			if DecreaseEvent == nil then
				task.wait(0.5)
				self.Utilities.Tween(TouchAnim.Touch1, self.Utilities.TI(0.5), {
					BackgroundTransparency = 1,
				})
				self.Utilities.Tween(TouchAnim.Touch2, self.Utilities.TI(1), {
					BackgroundTransparency = 1,
				})
				task.wait(0.5)
				TouchAnim:Destroy()
			else
				local Connection = nil

				Connection = DecreaseEvent:Connect(function()
					self.Utilities.Tween(TouchAnim.Touch1, self.Utilities.TI(0.5), {
						BackgroundTransparency = 1,
					})
					self.Utilities.Tween(TouchAnim.Touch2, self.Utilities.TI(0.5), {
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
		-- NonInteractable = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Idle = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,

		-- Hover = function(self)
		-- 	local Attributes = self.GuiObject:GetAttributes()
		-- end,

		Press = function(self)
			local Attributes = self.GuiObject:GetAttributes()

			local AnimLayer1 = self.GuiObject.Visual.AnimationLayer1

			self.Object.Functions.CreateTouch(self, AnimLayer1)
		end,
	},

	Tree = {
		{
			Path = "Interaction.UIPadding",
			Attributes = {
				Changeable = true,
			},
		},
		{
			Path = "Interaction.Button",
			GuiState = {
				Press = function(self)
					local Attributes = self.GuiObject:GetAttributes()

					local AnimLayer1 = self.Source.GuiObject.Visual.AnimationLayer1

					self.Source.Object.Functions.CreateTouch(self, AnimLayer1)
				end,
			},
		},
		{
			Path = "Visual.Layer1",
			Tree = {
				{
					ClassName = "Frame",
					Properties = {
						Size = UDim2.fromScale(1, 1),
					},
					Functions = {
						Init = function(self)
							local Attributes = self.Source.GuiObject:GetAttributes()

							self.GuiObject.BackgroundColor3 = Attributes.BackgroundColor
						end,
					},
				},
			},
		},
		{
			Path = "Visual.Layer2",
			Tree = {
				{
					Path = "UIPadding",
					Attributes = {
						Changeable = true,
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
