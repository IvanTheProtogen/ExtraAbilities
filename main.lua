local ExtraAbilities = {}

ExtraAbilities.GetVersion = function()return"1.4"end

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
			return "<NIL PARENT> "..nextinst.Name
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

-- I'm so happy to finally release an Adonis Anti-cheat bypass to ExtraAbilities. :D 

ExtraAbilities.BypassAdonisAnticheat = function() 
ExtraAbilities.Info("Please wait! The script is currently bypassing Adonis Anti-cheat before use!")
ExtraAbilities.Notify("Please wait!","The script is currently bypassing Adonis Anti-cheat before use!","rbxassetid://5273570766")



-- ADONIS ANTI-CHEAT DEACTIVATOR
-- By IvanIzWorthlessYT :D

-- Finally get to use RemoteSpy!

local RemoteKillerFinished = false -- This is for Anti-Kick part.

-- Only this part of code is skidded from Infinite Yield's Anti-Kick command. The rest is coded by me from scratch.

-- I added anti-kick, because Adonis Anti-cheat detects namecallInstances.

task.spawn(function()

while not RemoteKillerFinished do
task.wait(1) -- Wait until the Remote-killer finishes.
end 

local LocalPlayer = ExtraAbilities.CloneRef(game:GetService("Players")).LocalPlayer
local oldhmmi
local oldhmmnc
oldhmmi = hookmetamethod(game, "__index", function(self, method)
	if self == LocalPlayer and method:lower() == "kick" then
		return error("Expected ':' not '.' calling member function Kick", 2)
	end
	return oldhmmi(self, method)
end)
end)

oldhmmnc = hookmetamethod(game, "__namecall",function(self, ...)
	if self == LocalPlayer and getnamecallmethod():lower() == "kick" then
		return
	end
	return oldhmmnc(self, ...)
end)

-- Check, if the RemoteEvent has a name of GUID.

local function Check(inst,printresult)task.spawn(function()
    if typeof(inst) == "Instance" then 
        if inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction") or inst:IsA("UnreliableRemoteEvent") then 
            if ( ( string.sub(inst.Name,9,9) == "-" ) and ( string.sub(inst.Name,14,14) == "-" ) and ( string.sub(inst.Name,19,19) == "-" ) ) then
                if printresult then
                    print("An anti-cheat remote has been detected! Replacing it with a fake one...") -- Only if Adonis Anti-cheat doesn't use the remote in a Local Variable.
                    print("Replacing functions of all connections to Destroying, AncestryChanged and Changed events of the remote with blank functions...") -- I've realized how smart this is.
                end
				local BlankFunc = function(...)return...end
                for i,v in pairs(getconnections(inst.Destroying)) do
					v.Function = BlankFunc
				end
                for i,v in pairs(getconnections(inst.Changed)) do
					v.Function = BlankFunc
				end
                for i,v in pairs(getconnections(inst.AncestryChanged)) do
					v.Function = BlankFunc
				end
                Instance.new(inst.ClassName,inst.Parent).Name = inst.Name -- Replace the remote with it's plushie.
                inst:Destroy() -- Murder the remote.
            end
        end 
    end 
end)end

-- When testing, Adonis Anti-cheat regrabbed the remote, so I decided to do an anti-regrab.

warn("AUTO-CHECK ALL SPAWNED INSTANCES ENABLED, SO THE ADONIS ANTI-CHEAT WOULDN'T REGRAB THE REMOTEEVENT...")

game.DescendantAdded:Connect(function(inst)
    Check(inst,false)
end)

-- Get and check all instances from everything one-by-one

warn("GETTING INSTANCES FROM THE ABYSS...")

for i,v in pairs(getgc()) do -- From Garbage Collection and DataModel.
    Check(v,true)
end 

for i,v in pairs(getnilinstances()) do -- From NIL parent.
    Check(v,true)
end 

RemoteKillerFinished = true 



ExtraAbilities.Info("Successfully bypassed! The script is now ready to use!")
ExtraAbilities.Notify("Successfully bypassed!","The script is now ready to use!","rbxassetid://5273570766")
end 

ExtraAbilities.GetSenvID = function(v) 
	if typeof(getsenv(v)) ~= "table" then 
		return nil 
	end
	return string.sub(tostring(getsenv(v)),10,#tostring(getsenv(v)))
end 

ExtraAbilities.GetExploitScripts = function()

local ExploitScripts = {} -- All ExploitScripts will be here.

for i,v in pairs(getgc(true)) do -- Get everything from garbage collection. (Garbage Collection is the entire Lua world memory.)
    if typeof(v) == "Instance" then -- Filter out everything, except Instances.
        if v:IsA(script.ClassName) then -- Filter out all Instances, except ones with ExploitScript's true class.
            if getscripthash(v) == getscripthash(script) then -- Filter out everything, except ones with the same script hash as current ExploitScript's script hash.
                ExploitScripts[ExtraAbilities.GetSenvID(v)] = v -- Add the ExploitScript to the ExploitScripts table.
            end
        end
    end
end

return ExploitScripts -- Return the ExploitScripts table.

end

ExtraAbilities.GetExploitScript = function(id) -- THIS FUNCTION IS DEPRECATED AND SHOULDN'T BE USED FOR NORMAL WORK.

local ExploitScript = nil

for i,v in pairs(ExtraAbilities.GetExploitScripts()) do
	if string.match(ExtraAbilities.GetSenvID(v),ExtraAbilities.GetSenvID(script)) then 
		if ExploitScript == nil then 
			ExploitScript = v -- Why does it return the "script" variable?
		end 
	end 
end

return ExploitScript

end 

ExtraAbilities.GetScriptBySenvID = function(id)

local ReturningScript = nil

for i,v in pairs(getgc(true)) do 
	if typeof(v) == "Instance" then 
		if ( v:IsA("LocalScript") or v:IsA("ModuleScript") ) then 
			if string.match(ExtraAbilities.GetSenvID(v),ExtraAbilities.GetSenvID(script)) then 
				if ReturningScript == nil then 
					ReturningScript = v 
				end
			end 
		end 
	end 
end

return ReturningScript

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
return error("expected table, function or userdata, got "..typeof(val))
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
end

return ExtraAbilities
