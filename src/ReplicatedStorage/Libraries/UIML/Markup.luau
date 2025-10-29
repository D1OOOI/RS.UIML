--	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES
local RS = game:GetService("ReplicatedStorage")

local Module = {}
--	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS

--	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES

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
local function NewMetaData(NewMetaData, OldMetaData)
	for i, iObject in pairs(OldMetaData) do
		if NewMetaData[i] == nil then
			NewMetaData[i] = iObject
		end
	end

	return NewMetaData
end
----------------------------------------------------------------------------------------------------
Module.Extends = function(self, MetaData)
	local MarkupData = MetaData.Object.Extends

	if MarkupData.Theme == nil or MarkupData.Object == nil then
		return nil
	end

	local ExtendsTheme = self.Themes[MarkupData.Theme]
	local ExtendsMarkup = Find(ExtendsTheme.Objects, MarkupData.Object)

	ExtendsMarkup = require(ExtendsMarkup)

	ExtendsMarkup.Config = require(ExtendsTheme.Config)

	local ExtendsMetaData = NewMetaData({
		Utilities = require(ExtendsTheme.Utilities),

		GuiObject = MetaData.GuiObject,
		Object = ExtendsMarkup,

		Source = {
			GuiObject = MetaData.GuiObject,
			Object = ExtendsMarkup,
		},
	}, MetaData)

	self:Apply(ExtendsMetaData)

	return
end
----------------------------------------------------------------------------------------------------
Module.Properties = function(self, MetaData)
	for i, iObject in pairs(MetaData.Object.Properties) do
		pcall(function()
			MetaData.GuiObject[i] = iObject
		end)
	end
end
----------------------------------------------------------------------------------------------------
Module.Attributes = function(self, MetaData)
	local Attributes = MetaData.GuiObject:GetAttributes()

	for i, iObject in pairs(MetaData.Object.Attributes) do
		MetaData.GuiObject:SetAttribute(i, iObject)
		
		--if Attributes[i] == nil or typeof(Attributes[i]) ~= typeof(iObject) then
		--	MetaData.GuiObject:SetAttribute(i, iObject)
		--end
	end
end
----------------------------------------------------------------------------------------------------
Module.Tags = function(self, MetaData)
	for _i, iObject in pairs(MetaData.Object.Tags) do
		MetaData.GuiObject:AddTag(iObject)
	end
end
----------------------------------------------------------------------------------------------------
Module.Functions = function(self, MetaData)
	for i, Function in pairs(MetaData.Object.Functions) do
		if i == "Init" then
			local Success, Value = pcall(Function, MetaData)

			if Success == false then
				warn(`Error while executing Init function: [{Value}], Object: [`, MetaData.Object, `], GuiObject: [`, MetaData.GuiObject,`].`)
			end
		end
	end
end
----------------------------------------------------------------------------------------------------
Module.GuiState = function(self, MetaData)
	for GuiStateName, GuiStateFunction in pairs(MetaData.Object.GuiState) do
		for _k, EnumGuiState in pairs(Enum.GuiState:GetEnumItems()) do
			if EnumGuiState.Name == GuiStateName then
				MetaData.GuiObject:GetPropertyChangedSignal("GuiState"):Connect(function()
					if MetaData.GuiObject.GuiState == EnumGuiState then
						local Success, Value = pcall(GuiStateFunction, MetaData)

						if Success == false then
							warn(`Error while executing GuiState function: [{Value}], Object: [`, MetaData.Object, `], GuiObject: [`, MetaData.GuiObject,`].`)
						end
					end
				end)
			end
		end
	end
end
----------------------------------------------------------------------------------------------------
Module.Config = function(self, MetaData)
	for i, iObject in pairs(MetaData.Object.Config) do
		if i == "_Properties" then
			for k, kObject in pairs(iObject) do
				pcall(function()
					MetaData.GuiObject[k] = kObject
				end)
			end
		elseif i == "_Attributes" then
			local Attributes = MetaData.GuiObject:GetAttributes()

			for j, jObject in pairs(iObject) do
				MetaData.GuiObject:SetAttribute(j, jObject)
				
				--if Attributes[j] == nil or typeof(Attributes[j]) ~= typeof(jObject) then
				--	MetaData.GuiObject:SetAttribute(j, jObject)
				--end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------
Module.Tree = function(self, MetaData)
	for _i, Markup in pairs(MetaData.Object.Tree) do
		if typeof(Markup) ~= "table" then
			return nil
		end

		if Markup.ClassName ~= nil then
			local NewGuiObject = Instance.new(Markup.ClassName)
			NewGuiObject.Parent = MetaData.GuiObject

			local NewMetaData = NewMetaData({
				GuiObject = NewGuiObject,
				Object = Markup,
			}, MetaData)

			self:Apply(NewMetaData)
		elseif Markup.Path ~= nil then
			local TreeGuiObject = Find(MetaData.GuiObject, Markup.Path)

			if TreeGuiObject ~= nil then
				local NewMetaData = NewMetaData({
					GuiObject = TreeGuiObject,
					Object = Markup,
				}, MetaData)

				self:Apply(NewMetaData)
			end
		elseif Markup.Name ~= nil then
			local TreeGuiObject = MetaData.GuiObject:FindFirstChild(Markup.Name)

			if TreeGuiObject ~= nil then
				local NewMetaData = NewMetaData({
					GuiObject = TreeGuiObject,
					Object = Markup,
				}, MetaData)

				self:Apply(NewMetaData)
			end
		end
	end

	return
end
----------------------------------------------------------------------------------------------------
return Module
