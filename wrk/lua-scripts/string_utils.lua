math.randomseed(os.clock()*100000000000)

local string_utils = { _version = "0.0.1" }

local charset = "abcdefghijklmnopqrstuvwxyz"

function string_utils.random(length)
    local result = ""
    if length <= 0 then
        return result
    end
    for _ = 1, length, 1 do
        local index = math.random(1, charset:len())
        result = result .. charset:sub(index, index)
    end
    return result;
end

return string_utils