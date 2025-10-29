local Data = {}

for i, iObject in pairs(script:GetChildren()) do
	if iObject:IsA("ModuleScript") then
		Data[iObject.Name] = require(iObject)
	end
end

return Data
