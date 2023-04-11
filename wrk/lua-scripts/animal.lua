local string_utils = require("string_utils")
local json = require("json")

local Animal = {
    name;
    species;
}

function Animal:json()
    return json.encode(self);
end

Animal.__tostring = Animal.json;

function Animal:new(that)
    that = that or {};
    local animal = {
        name = that.name or string_utils.random(10);
        species = that.species or string_utils.random(10)
    }
    setmetatable(animal, self)
    self.__index = self
    return animal
end

return Animal