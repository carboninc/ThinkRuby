puts 'Как Вас зовут?'
name = gets.chomp

puts 'Какой у Вас рост?'
growth = gets.to_i

if growth > 0
  puts "#{name}, Ваш идеальный вес будет составлять #{growth - 110}"
else
  puts 'Ваш вес уже оптимальный'
end
