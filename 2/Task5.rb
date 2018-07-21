require 'date'

puts 'Укажите число:'
day = gets.to_i

puts 'Укажите месяц'
month = gets.to_i

puts 'Укажите год'
year = gets.to_i

beginning_year = Date.new(year, 1, 1).jd

date = Date.new(year, month, day).jd

result = date - beginning_year

# if (year % 4).zero? || (year % 400).zero?
#   puts result + 1
# else
#   puts result
# end

# Он сам учитывает високосный год или нет, но сверху я оставил алгоритм на всякий случай
puts result
