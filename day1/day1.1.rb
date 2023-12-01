def final_digit(digits)
  final_digit = digits.first + digits.last
  final_digit.to_i
end

total = 0
File.readlines('1.input', chomp: true).each do |line|
  digits = line.scan(/\d/)
  total += final_digit(digits)
  puts "#{digits} #{final_digit(digits)}"
end

puts total
