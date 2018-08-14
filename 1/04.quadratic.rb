puts 'Вычисляем квадратное алгебраическое уравнение'
puts 'Введите первый коэффицент'
a = gets.to_i

puts 'Введите второй коэффицент'
b = gets.to_i

puts 'Введите третий коэффицент'
c = gets.to_i

d = b**2 - (4 * a * c)

if d > 0
  discriminant = Math.sqrt(d)
  x1 = (-b + discriminant) / (2 * a)
  x2 = (-b - discriminant) / (2 * a)
  puts "Дискриминант равен #{d}, один корень равен #{x1}, второй корень равен #{x2}"
elsif d.zero?
  x = -b / (2 * a)
  puts "Дискриминант равен #{d}, корень равен #{x}"
else
  puts "Дискриминант равен #{d}, корней нет"
end
