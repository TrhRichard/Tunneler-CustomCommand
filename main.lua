local TCC = {}

local makeCustomCommand
if not game.ReplicatedStorage:FindFirstChild("makeCustomCommand") then
	makeCustomCommand = Instance.new("BindableEvent",game.ReplicatedStorage)
	makeCustomCommand.Name = "makeCustomCommand"
else
	makeCustomCommand = game.ReplicatedStorage:FindFirstChild("makeCustomCommand")
end

local event = makeCustomCommand.Event:Connect(function(name, callback)
	local helpcommand = game.ReplicatedStorage.DebugCommand.setlevel
	if game.ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()) then
		game.ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()):Destroy()
	end
	local command = helpcommand:Clone()
	command.Name = name:lower()
	command.Parent = game.ReplicatedStorage.DebugCommand
	require(game.ReplicatedStorage.DebugCommand:WaitForChild(name:lower())).runCommand = callback
end)

TCC.createCommand = function(name:string, callback)
	makeCustomCommand:Fire(name, callback)
	event:Disconnect()
end

TCC.runCommand = function(name: string, args: {})
	if not game.ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()) then
		warn(string.format("Command \"%s\" does not exist", name:lower()))
		return
	end

	args = args or {}
	require(game.ReplicatedStorage.DebugCommand:WaitForChild(name)).runCommand(args)
end

local UIS = game:GetService("UserInputService")
TCC.bindKeyToCommand = function(name: string, args: {}, key: Enum.KeyCode)
	if not game.ReplicatedStorage.DebugCommand:FindFirstChild(name:lower()) then
		warn(string.format("Command \"%s\" does not exist", name:lower()))
		return
	end
	
	_G.keysbinded = _G.keysbinded or {}

	if table.find(_G.keysbinded, key) then
		warn(string.format("Key %s already binded!", tostring(key)))
		return
	end

	args = args or {}

	table.insert(_G.keysbinded, key)

	UIS.InputBegan:Connect(function(inp, gpe)
		if gpe then return end

		if inp.KeyCode == key then
			TCC.runCommand(name, args)
		end
	end)
end

return TCC
