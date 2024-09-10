![ExtraAbilities](<https://github.com/IvanTheProtogen/ExtraAbilities/raw/main/ExtraAbilities.png>)

Welcome to the official documentation of ExtraAbilities, here you will learn how to use the ExtraAbilities module in your scripts.

For Exploits, functions that are required for some functions to work:
```
getgc
getsenv
require
game.HttpGet
getconnections
hookmetamethod
getscripthash
getscripts
getinstances
```

For functions, that are added in The Memory Search update, the `script` variable should not be fake. The fake `script` variables are stated in [Official Synapse X Documentation's Page 3.1](<https://web.archive.org/web/20220826150114/https://x.synapse.to/docs/development/script_env.html>).

Changelogs:
```
v1.0 -- The first release.
v1.1 -- The Adonis Anti-cheat Bypass Update: Part 1.
└ [ + ] Added BypassAdonisAnticheat function.
v1.2 -- The Memory Search update: Part 1.
├ [ + ] Added GetSenvID function.
├ [ + ] Added GetExploitScripts function.
└ [ + ] Added GetExploitScript function.
v1.2.1 -- The Memory Search update: Part 2.
├ [ * ] Deprecated GetExploitScript function.
├ [ / ] Modified GetSenvID function.
└ [ + ] Added GetScriptBySenvID function.
v1.3 -- The Information update.
├ [ + ] Added GetVersion function.
└ [ + ] Added changelogs.
v1.3.1 -- getgenv() mini-update.
└ [ + ] Added a "getgenv" file.
v1.4 -- The Memory Search update: Part 3.
├ [ * ] Undeprecated GetExploitScript function.
├ [ / ] Modified GetSenvID function.
├ [ / ] Modified GetExploitScript function.
├ [ / ] Modified GetScriptBySenvID function.
└ [ + ] Added GetValueByID function.
v1.5 -- The Adonis Anti-cheat Bypass Update: Part 2.
├ [ / ] Modified BypassAdonisAnticheat function.
└ [ + ] Added SafeDestroy function.
v1.6 -- The Memory Search update: Part 4.
└ [ + ] Added GetInstanceByDebugID function.
v1.7 -- "A bit of extra-sauce" update: Part 1.
├ [ + ] Added GetThreadIdentity function.
├ [ + ] Added FindPlayerByName function.
└ [ ! ] GetSecurityCapabilities function is soon!
v1.8 -- "A bit of extra-sauce" update: Part 2.
└ [ + ] Added GetSecurityCapabilities function.
v1.9 -- The "New Shape" update: Part 1.
├ [ - ] Removed GetExploitScript function.
├ [ - ] Removed GetScriptBySenvID function.
└ [ / ] Modified GetExploitScripts function.
v1.10 -- "A bit of extra-sauce" update: Part 3.
├ [ + ] Added FilterTableItems function.
├ [ + ] Added CleanupTable function.
└ [ - ] Removed GetSenvID function.
v1.11 -- "A bit of extra-sauce" update: Part 4.
└ [ + ] Added UncoverTable function.
v1.12 -- "A bit of extra-sauce" update: Part 5.
└ [ + ] Added FindPlayersAdvanced function.
```

# 1. Requiring the module.

In order to require the ExtraAbilities module, we should use `local`, `loadstring()` and `game:HttpGet()`.

```lua
local ExtraAbilities;if game:GetService("RunService"):IsClient()then ExtraAbilities=loadstring(game:HttpGet("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()else ExtraAbilities=loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/IvanTheProtogen/ExtraAbilities/main/main.lua"))()end;
```

Now, we've required the ExtraAbilities module, we have access to more functions, that we can use. Let's introduce the functions we now have.

## 1.1. IMPORTANT NOTE 

No, you can't use this module on the server.

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

## 2.7. GetHWID function.
This function returns a Hardware ID as a string. It is a shortcut to `game:GetService("RbxAnalyticsService"):GetClientId()`.

Example use:
```lua
print(ExtraAbilities.GetHWID()) -- Hardware ID...
```

## 2.8. GetIP function.
This function returns an IP address of the client as a string, thanks to [IPify](<https://ipify.org/>)'s API.

Example use:
```lua
print(ExtraAbilities.GetIP()) -- IP address...
```

## 2.9. CloneFunction function. (EXPLOIT-ONLY)

`ExtraAbilities.CloneFunction()` is a shortcut to `clonefunction()`, but with error handling. `clonefunction()` is a global exploit-only function, that clones the function and returns the cloned function to be used...I don't know, why this function exists at all.

Example use:
```lua
loadstring(ExtraAbilities.CloneFunction(game.HttpGet)("<<URL>>"))();
```

## 2.10. GetVersion function.

This function returns the current version of ExtraAbilities.

Example use:
```lua
print(ExtraAbilities.GetVersion()) -- "1.2.2"
```

## 2.11. GetThreadIdentity function.

This function returns the exact thread identity of a current script, using both `printidentity()` and `game:GetService("LogService").MessageOut`.

Example use:
```lua
print(ExtraAbilities.GetThreadIdentity()) -- Thread Identity...
```

_Information about Thread Identities can be seen [here](https://roblox.fandom.com/wiki/Security_context)._

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

## 3.8. DebugCode function. (EXPLOIT-ONLY)

`ExtraAbilities.DebugCode()` shows the works of the specific script to the player. It tells if the script execution was successful and how long did it take for the script to finish the work.

Example use:
```lua
ExtraAbilities.DebugCode([====[print("Hi!")wait(1)]===])
```

### 3.8.1. Development note.

Planning to make `ExtraAbilities.DebugFunction()` extra-function.

## 3.9. BypassAdonisAnticheat function. (EXPLOIT-ONLY) 

This function comes in handy, when trying to use a RemoteSpy in Adonis-protected games. 

Example use:
```lua
ExtraAbilities.BypassAdonisAnticheat()

-- And everything after...
```

## 3.10. GetSenvID function. (EXPLOIT-ONLY) [REMOVED]

_(This function has been removed, due to it's unstability and lack of worth. You may use a commit, but it would be unstable. Use the GetValueID and getsenv functions instead.)_ 

This function returns the ID of the script's environment. Useful, when comparing scripts with each other. 

Example use:
```lua
print(ExtraAbilities.GetSenvID(script)) -- hex code...
```

## 3.11. GetExploitScripts function. (EXPLOIT-ONLY) [RESHAPED]

_(This function has been reshaped and most scripts using this function may break, if not updated. If your script is using this function, please reshape your own script for the new function.)_

This function searches for and returns ExploitScripts in the game memory. This function is really powerful and you can make powerful scripts like ExploitSpys.

Returned dictionary:
```
{
	["0_123987"] = Script,
	["0_123123"] = Script,
	...
}
```

Example use:
```lua
-- This example code stops all currently running ExploitScripts.

for i,v in pairs(ExtraAbilities.GetExploitScripts()) do
	v.Disabled = true
end
```

## 3.12. GetExploitScript function. (EXPLOIT-ONLY) [REMOVED]

_(This function has been removed, due to it's unstability and lack of worth. You may use a commit, but it would be unstable. Use the GetInstanceByDebugID function instead.)_ 

This function searches for and returns the ExploitScript with the exact SenvID. Useful for ExploitSpys. 

Example use:
```lua
ExtraAbilities.GetExploitScript(ExtraAbilities.GetSenvID(script)).Disabled = true -- This disables itself.
```

## 3.13. GetScriptBySenvID function. (EXPLOIT-ONLY) [REMOVED]

_(This function has been removed, due to it's unstability and lack of worth. You may use a commit, but it would be unstable. Use the GetInstanceByDebugID function instead.)_ 

This function searches for and returns the script with the exact SenvID. Useful for ExploitSpys and ScriptSpys. 

Example use:
```lua
ExtraAbilities.GetScriptBySenvID(ExtraAbilities.GetSenvID(script)).Disabled = true -- This disables itself.
```

## 3.14. GetValueID function. 

This function returns an ID of the provided value. For now, the only currently supported values are table, function and userdata. 

Example use:
```lua
print(ExtraAbilities.GetValueID(print)) -- Value ID...
```

## 3.15. GetValueByID function. (EXPLOIT-ONLY)

This function is basically GetValueID, but reversed. It gets a specific table/function/userdata by provided ID from all memory. Returns `nil` if the value isn't found.

Example use:
```lua
ExtraAbilities.GetValueByID(ExtraAbilities.GetValue(print))("Hello World!") -- "Hello World!"
```

## 3.16. SafeDestroy function. (EXPLOIT-ONLY)

This function destroys any Instance, without triggering a few RBXScriptSignals, such as `Instance.Destroying`, `Instance.Changed`, `Instance.AncestryChanged` and `Instance:GetPropertyChangedSignal("Parent")`. This is useful for bypassing anti-cheats.

Example use:
```lua
Inst1:Destroy() -- Scripts notice the destruction.
ExtraAbilities.SafeDestroy(Inst2) -- No script notices the destruction.

## 3.17. GetInstanceByDebugID function. (EXPLOIT-ONLY)

This function returns an Instance with the exact debug ID, the Instance's debug ID can be retrieved via `Instance.GetDebugId` method.

Example use:
```lua
print(ExtraAbilities.GetInstanceByDebugID(script:GetDebugId())) -- Script
```

## 3.17. FindPlayerByName function.

This function returns a player by Display Name, Username or User ID, even if shortened. Returns `nil`, if player wasn't found.

Example use:
```lua
print(ExtraAbilities.FindPlayerByName(game:GetService("Players").LocalPlayer.DisplayName)) -- Display Name...
```

## 3.18. GetSecurityCapabilities function.

This function returns all security capabilities, that the script has. Really useful, when trying to find out the capabilities of an ExploitScript.

Example use:
```lua
assert(table.find(ExtraAbilities.GetSecurityCapabilities(), "RobloxScript") ~= nil, "Incompatible exploit! (Lacking capability RobloxScript)");
```

Returned array:
```
{
	"Plugin",
	"LocalUser",
	"RobloxScript",
	"RobloxEngine",
	"WritePlayer",
	"NotAccessible"
}
```

_Information about Security Capabilities can be seen [here](https://roblox.fandom.com/wiki/Security_context)._

## 3.19. FilterTableItems function.

This function is good for excluding items, already present in one table. Returns the table with items not present in tblA, other than tblB.

```lua
<table(array)> ExtraAbilities.FilterTableItems(<table(array): tblA>, <table(array): tblB>)
```

```
tblA -- Table to be filtered.
tblB -- List of items needed to remove from tblA.
```

Example use:
```lua
print(ExtraAbilities.FilterTableItems({1,2,3},{1,2})) -- {3}
```

## 3.20. CleanupTable function.

This function cleans up the table from item duplicates. Returns a cleaned-up table.

Example use:
```lua
print(ExtraAbilities.CleanupTable({1,2,3,3,3,3})) -- {1,2,3}
```

## 3.21. UncoverTable function.

This function unpacks all tables in one table, until no table is left. Also cleans up the table from duplicates. Returns the uncovered and clean table.

If it looped given times enough, it finishes.

```lua
<table(array)> ExtraAbilities.UncoverTable(<TableToUncover: table(any)>, <MaximumLoopsThroughTable: number>)
```

```
Before UncoverTable():

{
	1,
	{
		2,
		{
			3
		}
	}
}

After UncoverTable():

{
	1,
	2,
	3
}
```

Example use:

```lua
local extbl = {
	{1},
	{2},
	{3}
}

print(ExtraAbilities.UncoverTable(extbl,10)) -- {1, 2, 3}
```

## 3.22. FindPlayersAdvanced function. (CLIENT-ONLY)

This function returns a table with players in it, by using an identificator. Useful for admin scripts. 

Identificators:
```
all -- Returns ALL players, including the LocalPlayer.
others -- The same thing as "all", but excludes the LocalPlayer.
random -- Returns a table of some random player. (Does not include the LocalPlayer, if there's no players it will return a blank table.)
<playerName(ShortenedOrFull(DisplayOrUser))> -- Y'know that already.
```

Example use:
```lua
for i,v in ExtraAbilities.FindPlayersAdvanced("others") do
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
https://forum.wearedevs.net/
