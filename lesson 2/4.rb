alphabet = Hash.new

('a'..'z').each_with_index do |l, i|
  alphabet[l] = i + 1
end

puts alphabet