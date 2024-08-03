local ExtraAbilities = {}

ExtraAbilities.CloneRef = cloneref or function(...)return...end

ExtraAbilities.Notify = function(A,B,C,D,E,F,G) -- you can set values to nil, if you wanna skip them 
  -- to fix and prevent errors, when required data is invalid
	local fixedData = {["title"]=tostring(A),["text"]=tostring(B)}
    
  if C ~= nil then 
      fixedData[icon] = C
  end 
  if D ~= nil then 
      fixedData[duration] = D
  end 
  if E ~= nil then 
      fixedData[callback] = E
  end 
  if F ~= nil then 
      fixedData[button1] = F
  end 
  if G ~= nil then 
      fixedData[button2] = G
  end 
      
	return ExtraAbilities.CloneRef(game:GetService("Players")).LocalPlayer:FindFirstChildOfClass("PlayerGui"):SetCore("SendNotification",fixedData)
end 

ExtraAbilities.Message = function(...)
    return ExtraAbilities.CloneRef(game:GetService("TestService")):Message(...)
end 

ExtraAbilities.Message("This script is using ExtraAbilities module! (Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/)")
ExtraAbilities.Notify("This script is using ExtraAbilities module!", "Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/")

return ExtraAbilities
