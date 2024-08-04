local ExtraAbilities = {}

ExtraAbilities.CloneRef = cloneref or function(...)return...end

ExtraAbilities.IsServer = function()return ExtraAbilities.CloneRef(game:GetService("RunService")):IsServer()end
ExtraAbilities.IsClient = function()return ExtraAbilities.CloneRef(game:GetService("RunService")):IsClient()end

if ExtraAbilities.IsClient() then -- This function is clientside-only.
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
end

ExtraAbilities.Info = function(...)
    return ExtraAbilities.CloneRef(game:GetService("TestService")):Message(...)
end 

ExtraAbilities.Info("This script is using ExtraAbilities module! (Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/)")
ExtraAbilities.Notify("This script is using ExtraAbilities module!", "Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/", "rbxassetid://5273570766")

if ExtraAbilities.IsClient() then -- This function is exploit-only.
ExtraAbilities.SafeRequire = function(module) -- unlike original require(), this one is less harmful.
    if typeof(module) == "Instance" then 
        return require(module)
    elseif typeof(module) == "number" then 
        return loadstring(game:GetObjects("rbxassetid://"..tostring(module))[1].Source)() 
    else 
        error("Instance or number expected, got "..typeof(module), 0)
    end 
end 
end 

ExtraAbilities.QuickWait = function()return ExtraAbilities.CloneRef(game:GetService("RunService")).Heartbeat:Wait()end

ExtraAbilities.SmartWait = function(duration) 
    local previoustime = time()
    while time() < (previoustime+tonumber(duration)) do
        ExtraAbilities.QuickWait()
    end
end 

ExtraAbilities.GetTableType = function(tbl) -- oh boy this is starting to get fun 
    for key,value in pairs(tbl) do 
        if typeof(key) ~= "number" then 
            return "dictionary" 
        end 
    end 
    return "array" 
end 

ExtraAbilities.SmartTableItemCount = function(tbl) 
	local count = 0 
	for i,v in pairs(tbl) do 
		count=count+1 
	end 
	return count 
end

ExtraAbilities.WaitForSpecificDescendant = function(parent, data, argduration) -- example: ExtraAbilities.WaitForSpecificDescendant(workspace, { ["Name"] = "Part", ["ClassName"] = "Part", ["Parent"] = workspace })
    if ExtraAbilities.GetTableType(data) ~= "dictionary" then 
        error("dictionary expected, got "..ExtraAbilities.GetTableType(data), 0) 
    end 

	local dataAmount = ExtraAbilities.SmartTableItemCount(data)

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
            if catchedData >= dataAmount then 
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

    local dataAmount = ExtraAbilities.SmartTableItemCount(data)
        
    for index,instance in pairs(parent:GetDescendants()) do 
        local catchedData = 0
        for key,value in pairs(data) do 
            if instance[key] == value then     
                catchedData = catchedData+1 
            end 
        end 
        if catchedData >= dataAmount then 
            table.insert(returningtable,instance)
        end 
    end 

    return returningtable
end 

ExtraAbilities.Chat = function(str)cref=ExtraAbilities.CloneRef;return pcall(function()str=tostring(str)if cref(game:GetService("TextChatService")).ChatVersion==Enum.ChatVersion.TextChatService then cref(game:GetService("TextChatService")).TextChannels.RBXGeneral:SendAsync(str)else cref(game:GetService("ReplicatedStorage")).DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")end end)end;
ExtraAbilities.Message = ExtraAbilities.Chat

ExtraAbilities.FindHirerachy = function(inst)
	local nextinst = inst 
	local resultstr = ':WaitForChild("'..nextinst.Name..'")'
	local isReturned = false

	while not isReturned do 
		if nextinst.Parent == nil then 
			isReturned = true 
			return "<NIL PARENT> "..nextinst.Name
		elseif typeof(inst) ~= "Instance" then 
			isReturned = true 
			error("Instance expected, got "..typeof(nextinst),0) 
		else 
			if inst.Parent.Parent == game then 
				isReturned = true 
				return 'game:GetService("'..nextinst.Parent..'")' 
			else 
				resultstr = ':WaitForChild("'..nextinst.Parent..'")'..resultstr 
				nextinst = nextinst.Parent 
			end 
		end 
	end 

	return resultstr 
end

if ExtraAbilities.IsClient() then 
ExtraAbilities.DebugCode = function(src)

local previoustime = time() 

local returnstr = "SCRIPT EXECUTION FAILED"

local result = {pcall(function()loadstring(src)()end)}

local Leftover = ""

local Icon

if #result > 1 then
    for i=2,#result do
        pcall(function()Leftover = Leftover..tostring(result[i]).."\n"end)
    end
else
    pcall(function()Leftover = "<none>"end)
end

if result[1] == false then
    pcall(function()returnstr = "Failed to execute the script properly!" end)
	pcall(function()Icon="rbxassetid://5107154082"end)
elseif result[1] == true then
    pcall(function()returnstr = "Successfully executed the script without issues!" end)
	pcall(function()Icon="rbxassetid://12817454402"end)
else
    pcall(function()returnstr = "Something went wrong while executing the script!" end)
end

ExtraAbilities.Info(returnstr.." (Time Elapsed: "..tostring(time()-previoustime)..") Data:\n"..Leftover)
return ExtraAbilities.Notify(returnstr.." (Time Elapsed: "..tostring(time()-previoustime)..")", Leftover, Icon)

end 
end

return ExtraAbilities
