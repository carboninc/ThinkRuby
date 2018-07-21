numeric_array = []

(10..100).each do |number|
  numeric_array.push(number) if (number % 5).zero?
end

puts numeric_array
