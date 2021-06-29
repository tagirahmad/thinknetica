puts 'Write down h'
h = gets.chomp

puts 'Write down a'
a = gets.chomp

def triangle_square(a, h)
  puts (a * h) / 2
end

triangle_square a.to_f, h.to_f
