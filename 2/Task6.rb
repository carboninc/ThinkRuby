products = {}

while true
  puts 'Введите название товара:'
  product_name = gets.chomp

  break if product_name == 'стоп'

  puts 'Введите цену товара за еденицу:'
  product_price = gets.to_i

  puts 'Введите кол-во товара'
  product_count = gets.to_f

  products[product_name] = {
    price: product_price,
    count: product_count,
    total: (product_price * product_count).to_i
  }
end

puts products

total_sum = 0

products.each_value do |product|
  total_sum += product[:total]
end

puts '-----'
puts "Сумма всех покупок в корзине: #{total_sum}"
