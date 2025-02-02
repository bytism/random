-- https://v3rm.net/threads/beginner-reverse-engineering-tutorial-0-adonis.14455/

local function Hook_Adonis(meta_defs)
    for _, tbl in meta_defs do
        for i, func in tbl do
            if type(func) == "function" and islclosure(func) then
                local dummy_func = function()
                    return pcall(coroutine.close, coroutine.running())
                end
                print("hooking funcs")
                hookfunction(func, dummy_func)
                
            end
        end
    end
end
local function Init_Bypass()
    for i, v in getgc(true) do
        if
            typeof(v) == "table"
            and rawget(v, "indexInstance")
            and rawget(v, "newindexInstance")
            and rawget(v, "namecallInstance")
            and type(rawget(v,"newindexInstance")) == "table"
        then
            if v["newindexInstance"][1] == "kick" then
                Hook_Adonis(v)
            end
        end
    end
end
Init_Bypass()
