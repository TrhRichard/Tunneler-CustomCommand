# Tunneler-CustomCommand
make tunnelr custom commands

# Example

```lua
local TCC = loadstring(game:HttpGet('https://raw.githubusercontent.com/TrhRichard/Tunneler-CustomCommand/main/main.lua'))()
TCC.createCommand("test", function(args)
	-- just normal code
	return "!DEVERROR!this appears in the console"
end)
```
