months = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}

puts 'Укажите число:'
day = gets.to_i

puts 'Укажите месяц'
month = gets.to_i

puts 'Укажите год'
year = gets.to_i

months[:february] = 29 if (year % 4).zero? || (year % 400).zero?

result = day

i = 0
while i < month
  result += months.values[i]
  i += 1
end

puts "Указанная дата является #{result} в этом году"
