def main
  cart = {}

  # ПОчему этот способ не работает?

  # def ask_user(cart, run_app)
  #   puts "2) #{run_app.object_id}"
  #   puts 'Write product name'
  #   name = gets.chomp
  #   run_app = false if name == 'stop'
  #   puts 'Write product price'
  #   price = gets.chomp.to_f
  #   puts 'Write count'
  #   count = gets.chomp.to_i

  #   cart[name] = {
  #     price: price,
  #     count: count
  #   }
  # end

  # run_app = true
  # puts "1) #{run_app.object_id}"

  # ask_user(cart, run_app) while run_app

  loop do
    puts 'Write product name'
    name = gets.chomp
    break if name == 'stop'

    puts 'Write product price'
    price = gets.chomp.to_f
    puts 'Write count'
    count = gets.chomp.to_i

    cart[name] = {
      price: price,
      count: count
    }

    puts "Total product price: #{cart[name][:price] * cart[name][:count]}"

    total_cart_price = 0

    cart.each do |_, product_hash|
      total_cart_price += product_hash[:price] * product_hash[:count]
    end

    puts "Total cart price: #{total_cart_price}"
  end
end

main
