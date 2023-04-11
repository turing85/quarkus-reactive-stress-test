local json = require "json"

math.randomseed(os.clock()*100000000000)

Animal = {
    name = "";
    species= ""
}

local charset = "abcdefghijklmnopqrstuvwxyz"

function string.random(length)
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

function Animal:new()
    local animal = {
        name = string.random(5);
        species = string.random(5)
    }   -- create object if user does not provide one
    setmetatable(animal, self)
    self.__index = self
    return animal
end

function Animal:json()
    return json.encode(self);
end

local url_path = "/animals"
local headers = { ["Content-Type"] = "application/json;charset=UTF-8" }

request = function()
   return wrk.format("POST", url_path, headers, Animal:new():json())
end

done = function(summary, latency, _)
    io.write("-------------- CREATE ANIMALS -----------------\n")
    io.write(string.format("total number of requests: %d\n", summary.requests));
    io.write(string.format(
            "Non-2xx responses: %d (%.2f%%)\n",
            summary.errors.status,
            summary.errors.status / summary.requests * 100))
    io.write("-------------- Latency ------------------------\n")
    io.write(string.format("stdev: %f\n", latency.stdev))
    io.write(string.format("min: %d\n", latency.min))
    io.write(string.format("max: %d\n", latency.max))
    io.write("Percentiles:\n")
    for _, p in pairs({ 0.001, 0.01, 0.1, 1, 10, 50, 90, 99, 99.9, 99.99, 99.999 }) do
        n = latency:percentile(p)
        io.write(string.format("  %6.3f%% -> %d\n", p, n))
    end
	io.write("-----------------------------------------------\n\n")
end