fibonacci_numbers = [0]

previous_number = 1

while previous_number + fibonacci_numbers.last < 100
  sum = fibonacci_numbers.last + previous_number
  break if sum > 100
  previous_number = fibonacci_numbers.last
  fibonacci_numbers.push(sum)
end

puts fibonacci_numbers
