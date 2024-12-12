--[[
  disables fly, autoclick, hitbox detection and restores event names to theyre original ones
  https://www.roblox.com/games/4780772099/REVAMP-Miami-1986
]]

local Players = game:GetService('Players')
local StarterGui = game:GetService('StarterGui')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local Module = require(ReplicatedStorage.Folder.Modules.EventHandler)

local Connections = {
	LocalPlayer.Character.HumanoidRootPart.ChildAdded,
	LocalPlayer.CharacterAdded,
	Mouse.Button1Down,
}

LocalPlayer.PlayerGui:FindFirstChild('Client_HBED'):Destroy()
StarterGui:FindFirstChild('Client_HBED'):Destroy()

for _, Value in pairs(Connections) do
	for _, Connection in pairs(getconnections(Value)) do
		if typeof(Connection.Function) == 'function' then
			local Info = debug.getinfo(Connection.Function)
			
			if Info.short_src:find('SecureHandler') then
				Connection:Disable()
			end
		end
	end
end

for Index, Value in pairs(Module.Events) do
    local Connections = {
        Value.EventInstance:GetPropertyChangedSignal('Name'),
        Value.EventInstance.ChildAdded
    }

	for _, Value in pairs(Connections) do
		for _, Connection in pairs(getconnections(Value)) do
			Connection:Disable()
		end
	end

    Value.EventInstance.Name = Index
end
