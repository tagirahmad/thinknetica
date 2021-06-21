puts 'Write down a'
a = gets.chomp.to_i

puts 'Write down b'
b = gets.chomp.to_i

puts 'Write down c'
c = gets.chomp.to_i

def count_d a, b, c
  b**2  - (4 * a * c) 
end

def solve_equation d, a, b
  if d > 0 
    x1 = (-b + Math.sqrt(d)) / (2 * a)
    x2 = (-b - Math.sqrt(d)) / (2 * a)
    puts "D: #{d}, x1 = #{x1}, x2 = #{x2}"
  elsif d == 0
    x = (-b) / (2 * a)
    puts "D: #{d}, x1 = x2 and equals #{x}"
  else
    puts "D: #{d}. There is no any roots"
  end
end

solve_equation(count_d(a, b, c), a, b)