# RS.UIML

It doesn't look like HTML

## Install

  1. Get Plugin [UIML](https://create.roblox.com/store/asset/70518553415141/UIML) from Creator Store
  1. Place .rbxm file into Replicated Storage or use .rbxl place
  1. The UIML controller/module can be located anywhere and however you want.

:warning: The UIML plugin needs a structure like in [Here](/src/ReplicatedStorage) otherwise it will throw errors or won't run (in this case, reload the plugin) :warning:

## Plugin

  1. The plugin is completely (almost) synchronized with Replicated Storage, when you change any script it will be synchronized with the internal environment (because of this there may be quite a lot of errors in the output).
  1. If for some reason plugin does not see the update of a particular script, then change ancestor (which is a script) and then all descendants will be updated.

## Usage

### Module

```luau
local UIML = require("Somewhere it located")

UIML:Init()

local Frame = Instance.new("Frame")

Frame:SetAttribute("UITheme", "Framework")
Frame:SetAttribute("UIObject", "ToggleButton")

UIML:Apply(Frame)
```

### Controller

:warning: Not implemented yet :) :warning: