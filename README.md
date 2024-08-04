![ExtraAbilities](<https://github.com/IvanTheProtogen/ExtraAbilities/raw/main/ExtraAbilities.png>)

# [UNFINISHED]

Welcome to the official documentation of ExtraAbilities, here you will learn how to use the ExtraAbilities module in your scripts.

# 1. Requiring the module.

In order to require the ExtraAbilities module, we should use `local`, `loadstring()` and `game:HttpGet()`.

```lua
local ExtraAbilities = loadstring(game:GetService("HttpService"):GetAsync("http://github.com/IvanTheProtogen/ExtraAbilities/raw/main/main.lua"))();
```

Now, we've required the ExtraAbilities module, we have access to more functions, that we can use. Let's introduce the functions we now have.

# IMPORTANT NOTE

If you're using this module for your own Roblox Game, please remember to enable Allow HTTP Requests in Roblox Studio's Game Settings and enable LoadStringEnabled property under ServerScriptService in Roblox Studio.

![Allow HTTP Requests](<https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/3/2/3/323268ece17eb3c4046af2623e322de539320339.png>)

![LoadStringEnabled](<https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/6/5/2/652e3d049ce056fbc7372cee5ab526f06fc1b3f1.png>)

# 1.1. CloneRef function.

`ExtraAbilities.CloneRef()` is a shortcut to `cloneref()`, but with error handling. `cloneref()` is a global exploit-only function, 
