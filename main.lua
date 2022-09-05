local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local TCC = {}

_G.keysbinded = {}

local makeCustomCommand
if not ReplicatedStorage:FindFirstChild("makeCustomCommand") then
	makeCustomCommand = Instance.new("BindableEvent")
	makeCustomCommand.Parent = ReplicatedStorage
	makeCustomCommand.Name = "makeCustomCommand"
else
	makeCustomCommand = ReplicatedStorage:FindFirstChild("makeCustomCommand")
end

local event = makeCustomCommand.Event:Connect(function(name, callback)
	local helpcommand = ReplicatedStorage.DebugCommand.setlevel
	
	if ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()) then
		ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()):Destroy()
	end

	local command = helpcommand:Clone()
	command.Name = name:lower()
	command.Parent = ReplicatedStorage.DebugCommand
	
	require(ReplicatedStorage.DebugCommand:WaitForChild(name:lower())).runCommand = callback
end)

TCC.createCommand = function(name: string, callback)
	makeCustomCommand:Fire(name, callback)
	event:Disconnect()
end

TCC.runCommand = function(name: string, args: {}?)
	if not ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()) then
		warn(string.format("Command \"%s\" does not exist", name:lower()))
		return
	end

	args = args or {}
	require(ReplicatedStorage.DebugCommand:WaitForChild(name)).runCommand(args)
end

TCC.bindKeyToCommand = function(name: string, key: Enum.KeyCode, args: {}?)
	if not ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()) then
		warn(string.format("Command \"%s\" does not exist", name:lower()))
		return
	end

	if _G.keysbinded[key] ~= null then
		warn(string.format("Key %s already binded!", tostring(key)))
		return
	end

	local connection = UserInputService.InputBegan:Connect(function(inp, gpe)
		if gpe then return end

		if inp.KeyCode == key then
			TCC.runCommand(name, args or {})
		end
	end)

	_G.keysbinded[key] = {
		connection: connection
	} -- add more to this table if you need to
end

TCC.unbindKey = function(key: Enum.KeyCode)
	if _G.keysbinded[key] ~= null then
		_G.keysbinded[key].connection:Disconnect() -- no memory leaks richard
		_G.keysbinded[key] = null
	else
		warn(string.format("Key %s is not binded!", tostring(key)))
	end
end

return TCC
