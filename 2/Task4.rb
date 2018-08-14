vowels_array = %w[a e i o u y]
result = {}

('a'..'z').each.with_index(1) do |letter, index|
  result[letter] = index if vowels_array.include?(letter)
end

puts result
