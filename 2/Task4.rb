vowels_array = %w[a e i o u y]
result = {}

('a'..'z').each_with_index do |letter, index|
  result[letter] = index + 1 if vowels_array.include?(letter)
end

puts result
