local TCC = {}

local makeCustomCommand
if not game.ReplicatedStorage:FindFirstChild("makeCustomCommand") then
	makeCustomCommand = Instance.new("BindableEvent",game.ReplicatedStorage)
	makeCustomCommand.Name = "makeCustomCommand"
else
	makeCustomCommand = game.ReplicatedStorage:FindFirstChild("makeCustomCommand")
end

TCC.createCommand = function(name:string, callback)
	makeCustomCommand:Fire(name, callback)
end

makeCustomCommand.Event:Connect(function(name, callback)
	local helpcommand = game.ReplicatedStorage.DebugCommand.setlevel
	local command = helpcommand:Clone()
	command.Name = name
	command.Parent = game.ReplicatedStorage.DebugCommand
	require(game.ReplicatedStorage.DebugCommand:WaitForChild(name)).runCommand = callback
end)

return TCC
