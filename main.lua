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
	if game.ReplicatedStorage.DebugCommand:FindFirstChild(name) then
		game.ReplicatedStorage.DebugCommand:FindFirstChild(name):Destroy()
	end
	local command = helpcommand:Clone()
	command.Name = name
	command.Parent = game.ReplicatedStorage.DebugCommand
	require(game.ReplicatedStorage.DebugCommand:WaitForChild(name)).runCommand = callback
end)

TCC.createCommand = function(name:string, callback)
	makeCustomCommand:Fire(name, callback)
	event:Disconnect()
end

TCC.runCommand = function(name: string, args: {})
	if not game.ReplicatedStorage.DebugCommand:FindFirstChild(name) then
		warn(string.format("Command \"%s\" does not exist", name))
		return
	end
	
	args = args or {}
	require(game.ReplicatedStorage.DebugCommand:WaitForChild(name)).runCommand(args)
end

return TCC
