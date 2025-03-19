local function adoniscries()
    pcall(function()
        for _, instance in ipairs(game:GetDescendants()) do
            if instance.Name:lower():match("adonis") or
               instance.Name == "__FUNCTION" or
               instance.Name:match("ClientMover") then
                instance:Destroy()
            end
        end
    end)
    pcall(function()
        for _, instance in ipairs(getnilinstances()) do
            if instance:IsA("RemoteEvent") or
               instance:IsA("RemoteFunction") or
               instance.Name:match("ClientMover") or
               instance.Name == "__FUNCTION" then
                instance:Destroy()
            end
        end
    end)
    local oldFireServer
    oldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
        local args = {...}
        if typeof(args[1]) == "table" and args[1].Mode == "Get" then
            return
        end
        return oldFireServer(self, ...)
    end)
    return true
end
adoniscries()
