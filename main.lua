if getgenv().ExtraAbilities then 
	return getgenv().ExtraAbilities 
end 

local ExtraAbilities = {}

ExtraAbilities.GetVersion = function()return"1.13"end

ExtraAbilities.CloneRef = cloneref or function(...)return...end
ExtraAbilities.CloneFunction = clonefunction or function(...)return...end

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
if ExtraAbilities.IsClient()then ExtraAbilities.Notify("This script is using ExtraAbilities module!", "Get ExtraAbilities module here: https://github.com/IvanTheProtogen/ExtraAbilities/", "rbxassetid://5273570766")end 

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
			return "<NIL PARENT> "..resultstr
		elseif typeof(inst) ~= "Instance" then 
			isReturned = true 
			error("Instance expected, got "..typeof(nextinst),0) 
		else 
			if inst.Parent.Parent == game then 
				isReturned = true 
				return 'game:GetService("'..nextinst.Parent.Name..'")'..resultstr
			else 
				resultstr = ':WaitForChild("'..nextinst.Parent.Name..'")'..resultstr 
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

if ExtraAbilities.IsClient() then 
ExtraAbilities.GetIP = function() 
	return game:HttpGet("https://api64.ipify.org/")
end 
ExtraAbilities.GetHWID = function() 
	if gethwid then
		return gethwid()
	end	
	return game:GetService("RbxAnalyticsService"):GetClientId()
end 

ExtraAbilities.SafeDestroy = function(v)local NeutralizeConnection = function(con)for a,b in pairs(getconnections(con))do b:Disable()end end; NeutralizeConnection(v.Destroying)NeutralizeConnection(v.Changed)NeutralizeConnection(v.AncestryChanged)NeutralizeConnection(v:GetPropertyChangedSignal("Parent"))v:Destroy()end;ExtraAbilities.BypassAdonisAnticheat = function()for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do if v:IsA("RemoteEvent")then if ((string.sub(v.Name,9,9)=="-")and(string.sub(v.Name,14,14)=="-")and(string.sub(v.Name,19,19)=="-")and(string.sub(v.Name,24,24)=="-"))then Instance.new("RemoteEvent",game:GetService("ReplicatedStorage")).Name=v.Name;ExtraAbilities.SafeDestroy(v)end end end end

ExtraAbilities.BypassAdonisAnticheat = function()
print("Sorry! Moved to github.com/IvanTheProtogen/NoMoreAdonis !")
end 

ExtraAbilities.GetExploitScripts = function()

local ExploitScripts = {} -- All ExploitScripts will be here.

for i,v in pairs(getscripts()) do 
	if getscripthash(v) == getscripthash(script) then 
		ExploitScripts[tostring(v:GetDebugId())] = v 
	end 
end 

return ExploitScripts -- Return the ExploitScripts table.

end

end 

ExtraAbilities.GetValueID = function(val) -- table, function and userdata can be used.

local cmpr=function(typy)return (typeof(val)==typy)end;

a = tostring(val) 
b = #a 

if cmpr("table") then 
return string.sub(a,10,b)
elseif cmpr("function") then 
return string.sub(a,13,b)
elseif cmpr("userdata") then 
return string.sub(a,13,b)
else 
return error("expected table, function or userdata, got "..type(val))
end 

end 

if ExtraAbilities.IsClient() then 
ExtraAbilities.GetValueByID = function(id) 

local ReturningValue = nil 

for i,v in pairs(getgc(true)) do 
	if ( ( typeof(v) == "table" ) or ( typeof(v) == "function" ) or ( typeof(v) == "userdata" ) ) then 
		if string.match(ExtraAbilities.GetValueID(v),tostring(id)) then 
			if ReturningValue == nil then 
				ReturningValue = v 
			end 
		end 
	end
end 

return ReturningValue

end 

ExtraAbilities.GetInstanceByDebugID = function(id) 
	for i,v in pairs(getinstances()) do  
		if v:GetDebugId() == id then 
			return v 
		end 
	end 
	return nil 
end 
end 

ExtraAbilities.GetThreadIdentity = function()
	local threadidentity = 0
	local con = nil
	con = game:GetService("LogService").MessageOut:Connect(function(msg)
		if string.sub(msg,1,20) == "Current identity is " then
			threadidentity = tonumber(string.sub(msg,21,#msg))
			con:Disconnect()
		end
	end)
	printidentity()
	wait()
	return threadidentity 
end 

ExtraAbilities.FindPlayerByName = function(name)
	local plrs = game:GetService("Players")
	local namee = string.lower(name)
	for i,v in pairs(plrs:GetPlayers()) do 
		if string.lower(string.sub(v.DisplayName,1,#name)) == namee then 
			return v
		elseif string.lower(string.sub(v.Name,1,#name)) == namee then 
			return v 
		elseif string.lower(tostring(v.UserId)) == namee then 
			return v 
		end
	end 
	return nil 
end 

ExtraAbilities.GetSecurityCapabilities = function()
	-- The reason why RobloxPlace isn't there, it's because this capability no longer exists. (TestLocalUser doesn't exist too!)
	-- None isn't added, because it's a default capability, granted to all scripts. No script would be able to perform without None capability.
	
	-- Plugin -- game:GetService("CoreGui")
	-- LocalUser -- game:GetService("VersionControlService")
	-- RobloxScript -- game:GetService("CorePackages")
	-- RobloxEngine -- game:GetService("PlaceStatsService")
	-- WritePlayer -- Instance.new("Player")
	-- NotAccessible -- game:GetService("Chat").LoadDefaultChat = game:GetService("Chat").LoadDefaultChat 

	local capabilities = {}

	if pcall(function()print(game:GetService("CoreGui"))end) then table.insert(capabilities, "Plugin")end; -- Plugin 
	if pcall(function()print(game:GetService("VersionControlService"))end) then table.insert(capabilities, "LocalUser")end; -- LocalUser 
	if pcall(function()print(game:GetService("CorePackages"))end) then table.insert(capabilities, "RobloxScript")end; -- RobloxScript
	if pcall(function()print(game:GetService("PlaceStatsService"))end) then table.insert(capabilities, "RobloxEngine")end; -- RobloxEngine

	if pcall(function()Instance.new("Player")end) then table.insert(capabilities, "WritePlayer")end; -- WritePlayer
	if pcall(function()game:GetService("Chat").LoadDefaultChat=game:GetService("Chat").LoadDefaultChat end) then table.insert(capabilities, "NotAccessible")end; -- NotAccessible 

	return capabilities
end 

ExtraAbilities.FilterTableItems = function(tblA,tblB)
	-- tblA = Table to be filtered.
	-- tblB = List of items needed to remove.

	local tblC = {}
	for i,v in next,tblA do 
		if not table.find(tblB,v) then 
			table.insert(tblC,v) 
		end 
	end 
	return tblC 
end 

ExtraAbilities.CleanupTable = function(tbl)
	local tbll = {}
	for i,v in next,tbl do 
		if not table.find(tbll,v) then 
			table.insert(tbll,v)
		end 
	end 
	return tbll 
end 

ExtraAbilities.UncoverTable = function(tbl,maxloops)
	local function HasTable(tbll)
		for i,v in tbll do 
		if typeof(v) == "table" then 
				return true
			end 
		end 
		return false
	end 
	local tblll = tbl
	local isfinished = false 
	local doneloops = 0 
	if typeof(maxloops) ~= "number" then 
		maxloops = 100 
	end 
	if maxloops > 100 then 
		warn("[ ExtraAbilities ] Setting the maximum loop amount to above 100 may cause lag spikes and game freezing, careful!")
	end
	while not isfinished do 
		doneloops = doneloops + 1
		if HasTable(tblll) then 
			local tbllll = {}
			for i,v in tblll do 
				if typeof(v) == "table" then 
					for x,y in v do 
						table.insert(tbllll,y)
					end 
				else 
				    table.insert(tbllll,v)
				end 
			end 
			tblll = tbllll 
		else 
			isfinished = true 
		end 
		if doneloops >= maxloops then 
			isfinished = true 
		end 
	end 
	return ExtraAbilities.CleanupTable(tblll)
end 

local APIDump = nil 

ExtraAbilities.LoadAPIDump = function()
	if not APIDump then 
		print("[ ExtraAbilities ] Getting the full API dump, please wait...")
		APIDump = game:GetService("HttpService"):JSONDecode(game:HttpGet("http://github.com/MaximumADHD/Roblox-Client-Tracker/raw/roblox/Full-API-Dump.json"))
		print("[ ExtraAbilities ] Full API Dump retrieved!")
	end 
	return APIDump 
end 

ExtraAbilities.GetAllProperties = function(inst)
	local mmbrs = {}
	for i,v in pairs(ExtraAbilities.LoadAPIDump().Classes) do 
		if inst:IsA(tostring(v.Name)) then 
			for x,y in pairs(v.Members) do 
				if string.lower(y.MemberType) == string.lower("property") then 
					pcall(function() 
						if table.find(y,"Tags") then 
							if table.find(y.Tags,"NotScriptable") then 
								setscriptable(inst,y.Name,true)
							end 
						end 
						mmbrs[y.Name] = inst[y.Name]
					end)
				end 
			end 
		end 
	end
	return mmbrs 
end 

ExtraAbilities.GetAllServices = function()
	local srvs = {}
	for i,v in pairs(ExtraAbilities.LoadAPIDump().Classes) do 
		if table.find(v.Tags,"Service") then 
			pcall(function()
				srvs[v.Name] = game:GetService(v.Name)
			end)
		end
	end 
	return srvs 
end 

ExtraAbilities.NotifyRequest = function(title, desc, btnA, btnB)
	local response
	local bindfunc = Instance.new("BindableFunction")
	bindfunc.OnInvoke = function(responsee)
		response = responsee
	end
	ExtraAbilities.Notify(title, desc, nil, math.huge, bindfunc, btnA, btnB)
	repeat task.wait() until response~=nil
	return response
end

ExtraAbilities.InstancePointer = function(original, toPointAt)
	local pointer = {}
	pointer.Active = true
	pointer.Original = original
	pointer.PointAt = toPointAt
	setmetatable(pointer, {__tostring=function()return"InstancePointer"end})
	for i,v in getrawmetatable(pointer.Original) do
		if type(v) == "function" then
			local old;old = hookfunction(v, function(inst, ...)
				if inst==pointer.Original and pointer.Active then
					return old(pointer.PointAt, ...)
				end
				return old(inst, ...)
			end)
		end
	end 
	function pointer.CallMetamethod(mm, ...)
		local cuz = nil
		pointer.Active = false 
		task.spawn(function()
			cuz = {getrawmetatable(pointer.Original)[mm](pointer.Original, ...)}
		end)
		pointer.Active = true 
		repeat task.wait() until cuz 
		return table.unpack(cuz)
	end
	return pointer
end

ExtraAbilities = table.freeze(ExtraAbilities)

getgenv().ExtraAbilities = ExtraAbilities

return ExtraAbilities
