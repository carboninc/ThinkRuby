fibonacci_numbers = []

current_number = 1
previous_number = 1

loop do
  fibonacci_numbers.push(current_number)
  sum = current_number + previous_number
  previous_number = current_number
  current_number = sum
  break if current_number > 100
end

puts fibonacci_numbers
