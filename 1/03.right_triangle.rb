triangle_sides = []

puts 'Введите первую сторону труегольника'
triangle_sides.push(gets.to_i)

puts 'Введите вторую сторону треугольника'
triangle_sides.push(gets.to_i)

puts 'Введите третью сторону треугольника'
triangle_sides.push(gets.to_i)

triangle = triangle_sides.sort

a = triangle[0]

b = triangle[1]

c = triangle.max

if c == Math.sqrt(a**2 + b**2)
  if a == b
    puts 'Треугольник является прямоугольным и равнобедренным' if a == b
  else
    puts 'Треугольник прямоугольный'
  end
elsif a == b && a == c && b == c
  puts 'Треугольник равнобедренный и равносторонний, но не прямоугольный'
else
  puts 'Треугольник не прямоугольный'
end
