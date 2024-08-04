local ExtraAbilities = {}

ExtraAbilities.CloneRef = cloneref or function(...)return...end

ExtraAbilities.Notify = function(A,B,C,D,E,F,G) -- you can set values to nil, if you wanna skip them 
  -- to fix and prevent errors, when required data is invalid
	local fixedData = {["Title"]=tostring(A),["Text"]=tostring(B)}
    
  if C ~= nil then 
      fixedData["Icon"] = C
  end 
  if D ~= nil then 
      fixedData["Duration"] = D
  end 
  if E ~= nil then 
      fixedData["Callback"] = E
  end 
  if F ~= nil then 
      fixedData["Button1"] = F
  end 
  if G ~= nil then 
      fixedData["Button2"] = G
  end 
      
	return ExtraAbilities.CloneRef(game:GetService("StarterGui")):SetCore("SendNotification",fixedData)
end 

ExtraAbilities.Message = function(...)
	return ExtraAbilities.CloneRef(game:GetService("TestService")):Message(...)
end 

ExtraAbilities.Message("This script is using ExtraAbilities module! (Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/)")
ExtraAbilities.Notify("This script is using ExtraAbilities module!", "Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/", "rbxassetid://5273570766")

ExtraAbilities.SafeRequire = function(module) -- unlike original require(), this one is less harmful.
	if typeof(module) == "Instance" then 
		return require(module)
	elseif typeof(module) == "number" then 
		return loadstring(game:GetObjects("rbxassetid://"..tostring(module))[1].Source)() 
	else 
		error("Instance or number expected, got "..typeof(module), 0)
	end 
end 

ExtraAbilities.QuickWait = function()ExtraAbilities.CloneRef(game:GetService("RunService")).Heartbeat:Wait()end

ExtraAbilities.SmartWait = function(duration) 
	local previoustime = time()
	while time() < (previoustime+tonumber(duration)) do
		ExtraAbilities.QuickWait()
	end
end 

ExtraAbilities.GetTableType = function(table) -- oh boy this is starting to get fun 
	for key,value in pairs(table) do 
		if typeof(key) ~= "number" then 
			return "dictionary" 
		end 
	end 
	return "array" 
end 

ExtraAbilities.WaitForSpecificDescendant = function(parent, data, argduration) -- example: ExtraAbilities.WaitForSpecificDescendant(workspace, { ["Name"] = "Part", ["ClassName"] = "Part", ["Parent"] = workspace })
	if ExtraAbilities.GetTableType(data) ~= "dictionary" then 
		error("dictionary expected, got "..ExtraAbilities.GetTableType(data), 0) 
	end 

	local duration 
	if tonumber(argduration) ~= nil then 
		duration = tonumber(argduration) 
	else 
		duration = tonumber("inf") 
	end 

	while true do 
		for index,instance in pairs(parent:GetDescendants()) do 
			local catchedData = 0
			for key,value in pairs(data) do 
				if instance[key] == value then 
					catchedData = catchedData+1 
				end 
			end 
			if catchedData == #data then 
				return instance 
			end 
		end 
		wait() 
	end 
end 

ExtraAbilities.GetSpecificDescendants = function(parent, data) -- example: ExtraAbilities.WaitForSpecificDescendant(workspace, { ["Name"] = "Part", ["ClassName"] = "Part", ["Parent"] = workspace })
	local returningtable = {} 
	
	if ExtraAbilities.GetTableType(data) ~= "dictionary" then 
		error("dictionary expected, got "..ExtraAbilities.GetTableType(data), 0) 
	end 
		
	for index,instance in pairs(parent:GetDescendants()) do 
		local catchedData = 0
		for key,value in pairs(data) do 
			if instance[key] == value then 	
				catchedData = catchedData+1 
			end 
		end 
		if catchedData == #data then 
			table.insert(returningtable,instance)
		end 
	end 

	return returningtable
end 

ExtraAbilities.Chat = function(str)cref=ExtraAbilities.CloneRef;return pcall(function()str=tostring(str)if cref(game:GetService("TextChatService")).ChatVersion==Enum.ChatVersion.TextChatService then cref(game:GetService("TextChatService")).TextChannels.RBXGeneral:SendAsync(str)else cref(game:GetService("ReplicatedStorage")).DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")end end)end;

return ExtraAbilities
