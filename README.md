![ExtraAbilities](<https://github.com/IvanTheProtogen/ExtraAbilities/raw/main/ExtraAbilities.png>)

# [UNFINISHED]

Welcome to the official documentation of ExtraAbilities, here you will learn how to use the ExtraAbilities module in your scripts.

# 1. Requiring the module.

In order to require the ExtraAbilities module, we should use `local`, `loadstring()` and `game:HttpGet()`.

```lua
local ExtraAbilities;if game:GetService("RunService"):IsClient()then ExtraAbilities=loadstring(game:HttpGet("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()else ExtraAbilities=loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()end;
```

Now, we've required the ExtraAbilities module, we have access to more functions, that we can use. Let's introduce the functions we now have.

## 1.1. IMPORTANT NOTE

If you're using this module for your own Roblox Game, please remember to enable Allow HTTP Requests in Roblox Studio's Game Settings and enable LoadStringEnabled property under ServerScriptService in Roblox Studio.

![Allow HTTP Requests](<https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/3/2/3/323268ece17eb3c4046af2623e322de539320339.png>)

![LoadStringEnabled](<https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/6/5/2/652e3d049ce056fbc7372cee5ab526f06fc1b3f1.png>)

### 1.1.1. BE CAREFUL 

Enabling HTTP requests and LoadStringEnabled might put both your Roblox Game and Roblox Account under the risk, these 2 settings open more vulnerabilities to your Roblox Game's Replication Filtering and may increase the risk of backdoors.

Backdoors are hidden scripts and remotes, that allows all clients to execute code on serverside using backdoors. Backdoors allow clients to ban people.

If your Roblox Game is caught being backdoored by Roblox Moderation, your Roblox Game will be disabled and your account will be punished.

Do not worry, ExtraAbilities module doesn't place any kind of backdoor onto your game. It's source code is open and free-to-view and is not obfuscated at all. The only thing that is, kinda, obfuscated is the chat message function.

# 2. Basic functions.

This chapter is about basic functions

## 2.1. CloneRef function. (EXPLOIT-ONLY)

`ExtraAbilities.CloneRef()` is a shortcut to `cloneref()`, but with error handling. `cloneref()` is a global exploit-only function, that creates a reference to the instance to be used. This function helps exploits to bypass in-game anti-cheat scripts.

Example use:
```lua
ExtraAbilities.CloneRef(game:GetService("Workspace")).Part:Destroy();
```

## 2.2. Chat function. (CLIENT-ONLY)

`ExtraAbilities.Chat()` makes you chat any message possible, no matter what kind of version TextChatService has.

Example use:
```lua
ExtraAbilities.Chat("I like waffles!");
```

### 2.2.1. Message function. (CLIENT-ONLY)

`ExtraAbilities.Message()` is an alternative to `ExtraAbilities.Chat()`, which is equivalent to it.

## 2.3. Info function.

`ExtraAbilities.Info()` prints an information type of output into console.

Example use:
```lua
ExtraAbilities.Info("Successfully loaded!");
```

## 2.4. QuickWait function.

`ExtraAbilities.QuickWait()` is equivalent to `ExtraAbilities.CloneRef(game:GetService("RunService")).Heartbeat:Wait()`. This function is faster than both `wait()` and `task.wait()`.

Speed comparison:
```
wait() = 0.03 seconds
task.wait() = 0.01 seconds
ExtraAbilities.QuickWait() = 0.004 seconds
```

Example use:
```lua
while ExtraAbilities.QuickWait() do
	print("Hi!")
end
```

## 2.5. SmartWait function.

`ExtraAbilities.SmartWait()` is a custom `wait()` function, that uses both `ExtraAbilities.QuickWait()` and `time()`.

Example use:
```lua
print("Waiting 1 second...")
ExtraAbilities.SmartWait(1)
print("Waited 1 second.")
```

### 2.5.1. NOTICE 

Using this function will increase lag for a little bit. 

## 2.6. IsClient and IsServer functions.
`ExtraAbilities.IsClient()` and `ExtraAbilities.IsServer()` are shortcuts to `ExtraAbilities.CloneRef(game:GetService("RunService")):IsClient()` and `ExtraAbilities.CloneRef(game:GetService("RunService")):IsServer()`.

Example use:
```lua
if ExtraAbilities.IsServer() then
	print("This script is running on the server.")
else
	print("This script is running on the client.")
end
```


# 3. Advanced Functions.

This chapter contains functions, that are complex, complicated, but very useful for your scripts.

## 3.1. GetTableType function.

`ExtraAbilities.GetTableType()` is a table extra-function(), that can determine, if the table is an array or dictionary.

```lua
print(ExtraAbilities.GetTableType({1,2,3})) -- "array"
print(ExtraAbilities.GetTableType({["1"]=1,["2"]=2,["3"]=3})) -- "dictionary"
```

## 3.2. SmartTableItemCount function.

`ExtraAbilities.SmartTableItemCount()` counts items in the table more efficiently and stable than `#table`.

Example use:
```lua
local tbl = {["1"]=1,["2"]=2,["3"]=3}

print(#tbl) -- 0
print(ExtraAbilities.SmartTableItemCount(tbl)) -- 3
```

## 3.3. SafeRequire function. (EXPLOIT-ONLY)

Unlike `require()`, `ExtraAbilities.SafeRequire()` function provides more stability with requiring the asset properly.

Example use:
```lua
ExtraAbilities.SafeRequire(1234567890)();
```

## 3.4. Notify function. (CLIENT-ONLY)

`ExtraAbilities.Notify()` spawns a default Notification with provided settings.

In order to skip some data, you can use `nil`.

Dictionary use:
```
title     --    string                           --     (required)
text      --    string                           --     (required)
icon      --    string                           --     (optional)
duration  --    number                           --     5
callback  --    Instance (BindableFunction)      --     (optional)
button1   --    string                           --     (optional)
button2   --    string                           --     (optional)
```

Example use:
```lua
ExtraAbilities.Notify("Error!","Failed to load files!",nil,10)
```

## 3.5. FindHirerachy function.

`ExtraAbilities.FindHirerachy()` finds hirerachy (AKA ancestry) of an instance.

Example use:

```lua
print(ExtraAbilities.FindHirerachy(game.Players.LocalPlayer.Character)) -- 'game:GetService("Workspace"):WaitForChild("IvanTheProtogen0")'
```

### 3.5.1. Development Note.

Planning to make `ExtraAbilities.FindHirerachyTable()` to make scripts easier.

## 3.6. WaitForSpecificDescendant function.

`ExtraAbilities.WaitForSpecificDescendant()` waits for specific descendant with specific properties of one parent. If the duration times out, the extra-function errors. This extra-function is so useful, you won't believe how useful it is.

Into 1st argument, an Instance must be set.
Into 2nd argument, a dictionary of properties and values must be set.
Into 3rd argument, a number can be set, default value is Infinity.


Example use:
```lua
local properties = {
	["ClassName"] = "Model",
	["Name"] = "unknown",
	["Parent"] = workspace
}

ExtraAbilities.WaitForSpecificDescendant(workspace,properties):Destroy()
```

## 3.7. GetSpecificDescendants function.

`ExtraAbilities.GetSpecificDescendants()` gets specifc descendants of one parent with specific properties. Same arguments, except 3rd argument, from `ExtraAbilities.WaitForSpecificDescendant()` function.

Example use:
```lua
local properties = {
	["ClassName"] = "Part",
	["Name"] = "Sensory",
	["Parent"] = workspace,
	["Transparency"] = 1
}

for i,v in pairs(ExtraAbilities.GetSpecificDescendants(game,properties)) do
	v:Destroy()
end
```

# 4. Credits 

ExtraAbilities module and documentation are both made by IvanIzWorthless (AKA IvanTheProtogen).

Learn Roblox Lua here!:
http://lua.org/manual/
http://create.roblox.com/docs/
http://devforum.roblox.com/
https://web.archive.org/web/20220924132612/https://x.synapse.to/docs/
https://robloxapi.github.io/ref/
