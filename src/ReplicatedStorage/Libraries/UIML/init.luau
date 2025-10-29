--	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Module = {
	Themes = nil,
	MarkupFunctions = nil,
}
--	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS

--	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES

----------------------------------------------------------------------------------------------------
--	INIT		INIT		INIT		INIT		INIT		INIT		INIT		INIT	    INIT		INIT
----------------------------------------------------------------------------------------------------
function Module:Init()
	self.Themes = require(ReplicatedStorage.Data.UserInterface.Themes)
	self.MarkupFunctions = require(script.Markup)

	for _i, iObject in pairs(CollectionService:GetTagged("UserInterface")) do
		local MetaData = {
			GuiObject = iObject,
		}

		task.spawn(function()
			self:Apply(MetaData)
		end)

		iObject:RemoveTag("UserInterface")
	end
end
----------------------------------------------------------------------------------------------------
--	START		START		START		START		START		START		START		START		START		START
----------------------------------------------------------------------------------------------------
function Module:Start() end
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
function Module:Apply(MetaData)
	local Attributes = MetaData.GuiObject:GetAttributes()

	-- if GuiObject:IsA("GuiObject") == false then
	--     Framework.warn(`UIObject is not a GuiObject\
	-- UIObject.Name: [{GuiObject.Name}]`)
	--     return
	-- end

	if MetaData.Object == nil then
		if Attributes.UITheme == nil or Attributes.UIObject == nil then
			warn(`Attributes UITheme or UIObject is nil!\
    UIObject.Name: [{MetaData.GuiObject.Name}]`)
			return
		end

		local Theme = self.Themes[Attributes.UITheme]
		MetaData.Object = Find(Theme.Objects, Attributes.UIObject)

		if Theme == nil or MetaData.Object == nil then
			warn(`UITheme or UIML is nil!\
    UIObject.Name: [{MetaData.Object.Name}]`)
			return
		end

		MetaData.Object.Config = Theme.Config
		MetaData.Utilities = Theme.Utilities
	end

	if MetaData.Source == nil then
		MetaData.Source = {
			GuiObject = MetaData.GuiObject,
			Object = MetaData.Object,
		}
	end

	-- Applying
	if MetaData.Object.Extends ~= nil then
		pcall(self.MarkupFunctions.Extends, self, MetaData)
	end
	if MetaData.Object.Config ~= nil then
		pcall(self.MarkupFunctions.Config, self, MetaData)
	end

	for i, MarkupTable in pairs(MetaData.Object) do
		if i == "Extends" or i == "Functions" or i == "Config" then
			continue
		end

		if self.MarkupFunctions[i] ~= nil then
			pcall(self.MarkupFunctions[i], self, MetaData)
		end
	end

	if MetaData.Object.Functions ~= nil then
		pcall(self.MarkupFunctions.Functions, self, MetaData)
	end
end
----------------------------------------------------------------------------------------------------
return Module
