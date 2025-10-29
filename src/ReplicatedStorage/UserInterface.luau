--	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES	SERVICES
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")

local Framework = require(ReplicatedStorage.Framework)
local Controller = Framework:NewController({
	Name = script.Name,
	UIML = {},
})
local UIML = nil
--	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS	CONSTANTS

local PlayerGui, PlayerScripts = nil

local LocalPlayer = Players.LocalPlayer

--	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES	VARIABLES

----------------------------------------------------------------------------------------------------
--	INIT		INIT		INIT		INIT		INIT		INIT		INIT		INIT	    INIT		INIT
----------------------------------------------------------------------------------------------------
function Controller:Init()
	PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")

	UIML = require(ReplicatedStorage.Libraries.UIML)

	self:LoadStarterGui()
	UIML:Init()
end
----------------------------------------------------------------------------------------------------
--	START		START		START		START		START		START		START		START		START		START
----------------------------------------------------------------------------------------------------
function Controller:Start() end
----------------------------------------------------------------------------------------------------
--	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS	FUNCTIONS
----------------------------------------------------------------------------------------------------
function Controller:LoadStarterGui()
	for _i, iObject in pairs(ReplicatedFirst.StarterGui:GetChildren()) do
		if iObject:IsA("ScreenGui") then
			iObject:Clone().Parent = PlayerGui
		end
	end
end
----------------------------------------------------------------------------------------------------
function Controller.UIML:Apply(GuiObject)
	local MetaData = {
		GuiObject = GuiObject,
	}

	UIML:Apply(MetaData)
end
----------------------------------------------------------------------------------------------------
