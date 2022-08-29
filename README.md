# Tunneler Custom Command
make tunnelr custom commands

## DOCS

Create a Command
```lua
TCC.createCommand(name <string>, callback <function>)
```

Run a Command
```lua
TCC.runCommand(name <string>, args <table>: optional)
```

## Example

```lua
local TCC = loadstring(game:HttpGet('https://raw.githubusercontent.com/TrhRichard/Tunneler-CustomCommand/main/main.lua'))()
TCC.createCommand("test", function(args)
	-- just normal code
	return "!DEVERROR!wow this is red"
	-- !DEVERROR! before string makes the output red!!!!!
	-- return a string so that it appears in the console

end)

TCC.runCommand("setlevel", {"devtest_pool"})
```
