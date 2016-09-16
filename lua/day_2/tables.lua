-- TABLES AND COROUTINES

-- Tables define data
-- Coroutines define control flow

-- Tables are key value pairs

book = {
  title  = "Grail Diary",
  author = "Henry Jones",
  pages  = 100
}

-- DOT NOTATION

-- Fetching values
=book.title

-- Modifying values
book.stars = 5
book.author = "Henry Jones Sr."

-- SQUARE BRACKETS
-- square brackets are used at runtime
-- or keys with spaces or decimals

-- Any data type can be used as a table key
-- booleans, functions, other tables

key = "title"
=book[key]

-- Item removal, set item to nil
book.pages = nil

-- No functionality to print table defined in lua
-- pairs is an iterator designed to plug into a for loop

function print_table(t)
  for k, v in pairs(t) do
    print(k .. ": " .. v)
  end
end

-- including files via interactive lua
dofile('util.lua')

-- or launch lua, preloading library using -l
lua -l util

-- ARRAYS

-- Keys are sequential numbers in tables, no special array type
medals = {
  "gold",
  "silver",
  "bronze"
}

-- read
=medals[1]

-- write
medals[4] = "lead"

-- Lua array indexes begin at 1

-- Arrays and dicts can be mixed
ice_cream_scoops = {
  "vanilla",
  "chocolate";

  sprinkles = true
}
=ice_cream_scoops[1]
=ice_cream_scoops.sprinkles

-- METATABLES
-- Table behind the table

-- similar to python dunder methods or js prototypes
greek_numbers = {
  ena = "one",
  dyo = "two",
  tria = "three"
}

=getmetatable(greek_numbers)

-- to print metatable as string
function table_to_string(t)
  local result = {}

  for k, v in pairs(t) do
    result[#result + 1] = k .. ": " .. v
  end

  return table.concat(result, "|n")
end

-- connect metatable string dunder method
mt = {
  __tostring = table_to_string
}

setmetatable(greek_number, mt)
=greek_numbers

-- Reading/Writing

-- see strict.lua

-- Roll Your Own OO

dietrich = {
  name = "Dietrich",
  health = 100,

  take_hit = function(self)
    self.health = self.health - 10
  end
}

dietrich.take_hit(dietrich)
print(dietrich.health)

clone = {
  name = dietrich.name,
  health = dietrich.health,
  take_hit = dietrich.take_hit
}

-- two distinct objects
print(clone.health)

-- Prototypes

Villain = {
  health = 100,

  new = function(self, name)
    local obj = {
      name = name,
      health = self.health,
    }
    return obj
  end,

  take_hit = function(self)
    self.health = self.health - 10
  end
}

dietrich = Villain.new(Villain, "Dietrich")
Villain.take_hit(dietrich)
-- => ok

-- unfortunately the old dietrich take_hit
-- implementation will no longer work
dietrich.take_hit(dietrich)
-- => error: attempt to call field 'take_hit' (a nil value)

-- Implementing new function on metatable
-- setmetatable and dunder index is lua speak for
-- "use this tables fields as a backup"

new = function(self, name)
  local obj = {
    name = name,
    health = self.health,
  }

  setmetatable(obj, self)
  self.__index = self

  return obj
end

-- Inheritance

SuperVillain = Villain.new(Villain)

function SuperVillain.take_hit(self)
  self.health = self.health - 5
end

toht = SuperVillain.new(SuperVillain, "Toht")
toht.take_hit(toht)
print(toht.health)

-- Syntactic Sugar

Villain = { health = 100 }

function Villain:new(name)
  -- same implementation
end

function Villain:take_hit()
  -- same implementation
end

SuperVillain:new()

function SuperVillain:take_hit()
  -- Same implementation as before
end

dietrich = Villain:new("Dietrich")
dietrich.take_hit()
print(dietrich.health)

toht = SuperVillain:new("Toht")
toht:take_hit()
print(toht.health)

-- Coroutines

-- coroutines, like threads, allow your program
-- to have multiple tasks in progress

-- conceptually simpler and eliminate a whole class
-- of concurrency problems

-- Coroutines do not play well with blocking I/O calls

function fibonacci()
  local m = 1
  local n = 1

  while true do
    coroutine.yield(m)
    m, n = n, m + n
  end
end

-- Each time a new fibbonaci number, it yields to the caller
-- when we yield, we return to the same spot in our program later

generator = coroutine.create(fibonacci)
succeeded, value = coroutine.resume(generator)
=value
-- => 1
succeeded, value = coroutine.resume(generator)
=value
-- => 1
succeeded, value = coroutine.resume(generator)
=value
-- => 2

-- Multitasking

-- OS scheduler...
function punch()
  for i = 1, 5 do
    print('punch' .. i)
    scheduler.wait(1.0)
  end
end

function block()
  for i = 1, 3 do
    print('block' .. i)
    scheduler.wait(2.0)
  end
end

-- schedule them to run
scheduler.schedule(0.0, coroutine.create(punch))
scheduler.schedule(0.0, coroutine.create(block))

scheduler.run()
