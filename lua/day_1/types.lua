-- PRINTING
-- printing strings
print "No time for love"
-- multiline print
print
  "No time for love"
-- split print
print "No time" print "for love"

-- DATA TYPES

-- no integers (only floating point #'s') in lua, unless rebuilt with integers

-- floating point
=3.14
-- boolean
=true
-- string
="The dog's name was 'Indiana'"

-- escaped string
='Separated\tby\t\ttabs'

-- concatanation with glory operator
='fortune' .. ' and ' .. 'glory'

-- String length
=#'professor'

-- nil is a type
-- represents not found or does not exist
=some_var_that_does_not_exist

-- EXPRESSIONS
=6 +5 * 4 - 3 / 2
=6 + (5 * 4) - (3 / 2) 24.5
=(6 + 5) * (4 - 3) / 2

-- exponentation
=2 ^ 3
-- modulo
=1899 % 100

-- BOOLEAN OPERATORS
-- lua uses and, or, not
=not((true or false) and false)
=true or some_function()

-- EQUALITY
='cobras' < 'rats'
=#'cobras' < #'rats'

-- cannot compare different data types
-- cannot compare booleans

-- FUNCTIONS

function triple(num)
  return 3 * num
end

=triple(2)

-- function name is not necessary

=(function(num) return 3 * num end)(2)

-- Functions are first class (can be passed, stored as variables or stored in data structures)

-- ex. call_twice takes func as arg, returns a func that calls func arg twice

function call_twice(f)
  ff = function(num)
    return f(f(num))
  end
  return ff
end

function triple(n)
  return n * 3
end

times_nine = call_twice(triple)
=times_nine(5)

-- FLEXIBLE ARGS
function print_characters(friend, foe)
  print('*Friend or foe*')
  print(friend)
  print(foe)
end

print_characters('Marcus', 'Belloq')
-- Returns nil for missing arg
print_characters('Marcus')

-- Extra params are ignored
print_characters('Marcus', 'Belloq', 'unused')

-- VARIADIC FUNCTION
-- last param is an ellipsis
function print_characters(friend, ...)
  print('*Friend*')
  print(friend)

  print('*Foes*')
  foes = {...}
  print(foes[1])
  print(foes[2])
end

-- print(foes[2]) returns nil
print_characters('Marcus', 'Belloq')
--
print_characters('Marcus', 'Belloq', 'Donovan')

-- TAIL CALL OPTIMIZATION
-- lua is tail call optimized

function reverse(s, t)
  if #s < 1 then return t end
  first = string.sub(s, 1, 1)
  rest = string.sub(s, 2, -1)
  -- reminder: .. == string concat
  return reverse(rest, first .. t)
end

large = string.rep('hello', 5000)
print(reverse(large, ''))

-- MULTIPLE RETURN VALUES
function weapons()
  return 'bullwhip', 'revolver'
end

w1 = weapons()
print(w1)

-- nice!
w1, w2 = weapons()

print(w1)
print(w2)

-- missing assignment will return nil
w1, w2, w3 = weapons()

print(w1)
print(w2)
print(w3)

-- KEYWORD ARGUMENTS
-- no special syntax, but same effect by passing table as arg
function popcorn_prices(table)
  print('A medium popcorn costs ' .. table.medium)
end

-- lua doesn't require parens when invoking function with table as arg
popcorn_prices{small=5.00,
               medium=7.00,
               jumbo=15.00}

-- CONTROL FLOW

-- if, for and while

-- if else
-- Mixture between ruby if else and case...
film = 'Skull'
if film == 'Raiders' then
  print('Good')
elseif film == 'Temple' then
  print('Meh')
elseif film == 'Crusade' then
  print('Great')
else
  print('Huh?')
end

-- for loops
for i = 1, 5 do
  print(i)
end
-- have optional step argument
for i = 1, 5, 2 do
  print(i)
end

-- loop over items in a collection

-- while loop
while math.random(100) < 50 do
  print('Tails; flipping again')
end

-- VARIABLES
-- variables are global by default

function hypotenuse(a, b)
  a2 = a * a
  b2 = b * b

  return math.sqrt(a2 + b2)
end

=hypotenuse(3, 4)
-- a2 leaks outside the function
=a2

-- Local keyword
-- avoid scope leakageeeessssss
function hypotenuse(a, b)
  local a2 = a * a
  local b2 = b * b

  return math.sqrt(a2 + b2)
end

