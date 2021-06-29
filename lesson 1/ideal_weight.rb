puts 'Please, enter your name'
name = gets.chomp

puts 'Please, enter your height'
height = gets.chomp

def count_ideal_weight(name, height)
  ideal_weight = (height - 110).to_f * 1.15

  if ideal_weight < 0
    puts 'Your weight is already optimal'
  else
    puts "#{name}! Your ideal weight is #{ideal_weight}"
  end
end

count_ideal_weight name, height.to_i
