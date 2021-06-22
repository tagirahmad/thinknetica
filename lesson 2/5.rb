puts 'Enter a day'
day = gets.chomp.to_i

puts 'Enter a month'
month = gets.chomp.to_i

puts 'Enter a year'
year = gets.chomp.to_i

months = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

months[2] = 29 if ((year % 400 == 0) && (year % 4 == 0)) || (year % 100 != 0)

past_monts = months.select{|key, val| key < month } 

puts "Days: #{past_monts.values.sum + day}"
