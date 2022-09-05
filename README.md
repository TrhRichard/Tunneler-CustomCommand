# Tunneler Custom Command
make tunnelr custom commands

## DOCS

Create a Command
```lua
TCC.createCommand(name: string, callback: function)
```

Run a Command
```lua
TCC.runCommand(
	name: string,
	args: table? -- optional
)
```

Bind and unbind key to command
```lua
TCC.bindKeyToCommand(
	name: string,
	key: Enum.KeyCode,
	args: table? -- optional
)

TCC.unbindKey(key: Enum.KeyCode)
```

## Example

```lua
local TCC = loadstring(game:HttpGet('https://raw.githubusercontent.com/TrhRichard/Tunneler-CustomCommand/main/main.lua'))()

TCC.createCommand("test", function(args)
	-- just normal code
	return "!DEVERROR!wow this is red"
	-- return a string so that it appears in the console
	-- !DEVERROR! before the rest of the string makes the output red!!!!!

end)

TCC.bindKeyToCommand("test", Enum.KeyCode.F)
TCC.runCommand("setlevel", {"devtest_pool"})
```
