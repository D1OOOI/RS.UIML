--	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RF = game:GetService("ReplicatedFirst")

local Framework = require(RS.Framework)
local Controller = Framework:NewController({
	Name = script.Name,
	UIML = {
		Themes = nil,
		MarkupFunctions = nil,
	},
})
--	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS

local PlayerGui, PlayerScripts = nil

local LocalPlayer = Players.LocalPlayer

-- type UIML_Markup = { -- User Interface Markup Language (UIML)
-- 	Properties: any,
-- 	Attributes: any,
-- 	Tags: any,
-- 	Functions: any,
-- 	GuiState: any,
-- 	Tree: any,
-- 	[any]: any,
-- }

--	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES

----------------------------------------------------------------------------------------------------
--	INIT		INIT		INIT		INIT		INIT		INIT		INIT		INIT	    INIT		INIT
----------------------------------------------------------------------------------------------------
function Controller:Init()
	PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")

	self:LoadStarterGui()
	self.UIML:Init()
end
----------------------------------------------------------------------------------------------------
--	START		START		START		START		START		START		START		START		START		START
----------------------------------------------------------------------------------------------------
function Controller:Start() end
----------------------------------------------------------------------------------------------------
--	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS
----------------------------------------------------------------------------------------------------
local function Find(Source, Path: string)
	local Target = Source

	if Target == nil then
		return Target
	end

	for _i, iObject in pairs(Path:split(".")) do
		if typeof(Source) == "table" then
			Target = Target[iObject]
		else
			Target = Target:FindFirstChild(iObject)
		end
	end

	return Target
end
----------------------------------------------------------------------------------------------------
function Controller.UIML:Init()
	self.Themes = require(RS.Data.UserInterface.Themes)
	self.MarkupFunctions = require(script.Markup)

	for _i, iObject in pairs(CollectionService:GetTagged("UserInterface")) do
		task.spawn(function()
			self:Apply(iObject)
		end)

		iObject:RemoveTag("UserInterface")
	end
end
----------------------------------------------------------------------------------------------------
function Controller.UIML:Apply(Object: GuiObject, Markup, SourceObject: GuiObject, SourceMarkup)
	local Attributes = Object:GetAttributes()

	-- if GuiObject:IsA("GuiObject") == false then
	--     Framework.warn(`UIObject is not a GuiObject\
	-- UIObject.Name: [{GuiObject.Name}]`)
	--     return
	-- end

	if Markup == nil then
		if Attributes.UITheme == nil or Attributes.UIObject == nil then
			Framework.warn(`Attributes UITheme or UIObject is nil!\
        UIObject.Name: [{Object.Name}]`)
			return
		end

		local Theme = self.Themes[Attributes.UITheme]
		Markup = Find(Theme.Objects, Attributes.UIObject)

		if Theme == nil or Markup == nil then
			Framework.warn(`UITheme or UIML is nil!\
        UIObject.Name: [{Object.Name}]`)
			return
		end

		Markup.Config = Theme.Config

		SourceObject = Object
		SourceMarkup = Markup
	end

	-- Applying
	if Markup.Extends ~= nil then
		pcall(self.MarkupFunctions.Extends, self, Object, Markup, SourceObject, SourceMarkup)
	end

	for i, MarkupTable in pairs(Markup) do
		if i == "Extends" or i == "Functions" then
			continue
		end

		if self.MarkupFunctions[i] ~= nil then
			pcall(self.MarkupFunctions[i], self, Object, Markup, SourceObject, SourceMarkup)
		end
	end

	if Markup.Functions ~= nil then
		pcall(self.MarkupFunctions.Functions, self, Object, Markup, SourceObject, SourceMarkup)
	end
end
----------------------------------------------------------------------------------------------------
function Controller:LoadStarterGui()
	for _i, iObject in pairs(RF.StarterGui:GetChildren()) do
		if iObject:IsA("ScreenGui") then
			iObject:Clone().Parent = PlayerGui
		end
	end
end
----------------------------------------------------------------------------------------------------
