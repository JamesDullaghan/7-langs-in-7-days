-- Write a function called ends_in_3(num)
 -- that returns true if the final digit of num is 3, and false otherwise.
function ends_in_3(num)
  local string_num = tostring(num)
  return string.sub(string_num, #string_num, #string_num) == "3"
end

-- Now, write a similar function called is_prime(num) to test if a number is prime
-- (that is, it’s divisible only by itself and 1).
function is_prime(num)
  local half = math.ceil(num / 2)

  if half > 1 then
    if num % half == 0 then
      return false
    end

    is_prime(num - 1)
  end
  return true
end

print("4332 ends in 3: ", ends_in_3(4332))
print("4333 ends in 3: ", ends_in_3(4333))

print("2 is prime: ", is_prime(2))
print("7 is prime: ", is_prime(7))
print("14 is prime: ", is_prime(14))
print("3539 is prime: ", is_prime(3539))

-- Create a program to print the first n prime numbers that end in 3.
function first_n_primes_ending_in_3(n, num)
  value = num or 1

  if n > 0 then
    if ends_in_3(value) and is_prime(value) then
      print(value)
      n = n - 1
    end

    first_n_primes_ending_in_3(n, value + 1)
  end
end

print("first (n) primes ending in 3: ", first_n_primes_ending_in_3(2))

function reduce(max, init, f)
  if max > 0 then
    init = f(init, max)

    -- Print the final reduction
    if max == 1 then
      print(init)
    end

    reduce(max - 1, init, f)
  end

end

function add(previous, next)
  return previous + next
end

function factorial(previous, next)
  return previous * next
end

print(reduce(5, 0, add))
print(reduce(5, 1, factorial))
