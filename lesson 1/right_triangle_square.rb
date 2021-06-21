puts 'Write down a side'
a = gets.chomp.to_i

puts 'Write down b side'
b = gets.chomp.to_i

puts 'Write down c side'
c = gets.chomp.to_i

def triangle(a, b, c)
  if check_is_equilateral_triangle? a, b, c
    puts 'equilateral triangle'
  elsif check_is_isosceles_triangle? a, b, c
    puts 'isosceles triangle'
  elsif check_is_right_triangle? a, b, c
    puts 'right triangle'
  else
    puts 'another triangle'
  end
end

# проверка на прямоугольный т.
def check_is_right_triangle?(a, b, c)
  sides = [a, b, c]
  max_side = sides.max
  two_other_sides = sides.delete_if { |i| i == max_side }

  max_side**2 == (two_other_sides[0]**2 + two_other_sides[1]**2)
end

# проверка на равнобедренный т.
def check_is_isosceles_triangle?(a, b, c)
  if a == b || b == c || a == c
    true
  else
    false
  end
end

# проверка на равносторонний т.
def check_is_equilateral_triangle?(a, b, c)
  if a == b && b == c
    true
  else
    false
  end
end

triangle a, b, c
