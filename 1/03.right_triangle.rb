triangle_sides = []

puts 'Введите первую сторону труегольника'
triangle_sides.push(gets.to_f)

puts 'Введите вторую сторону треугольника'
triangle_sides.push(gets.to_f)

puts 'Введите третью сторону треугольника'
triangle_sides.push(gets.to_f)

a, b = triangle.min(2)

c = triangle.max

if c == Math.sqrt(a**2 + b**2)
  if a == b
    puts 'Треугольник является прямоугольным и равнобедренным'
  else
    puts 'Треугольник прямоугольный'
  end
elsif a == b && a == c && b == c
  puts 'Треугольник равнобедренный и равносторонний, но не прямоугольный'
else
  puts 'Треугольник не прямоугольный'
end
