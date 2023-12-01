INVERSE_NUMBER = {
  'eno' => '1',
  'owt' => '2',
  'eerht' => '3',
  'ruof' => '4',
  'evif' => '5',
  'xis' => '6',
  'neves' => '7',
  'thgie' => '8',
  'enin' => '9',
}
NUMBER = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
}

def final_digit(line)
  final_digit = first_digit(line) + last_digit(line)
  final_digit.to_i
end

def first_digit(line)
  line.scan(/\d|one|two|three|four|five|six|seven|eight|nine|/).reject{ |x| x.empty?}.map{|x| NUMBER[x] ? NUMBER[x] : x }.first
end

def last_digit(line)
  line.reverse.scan(/\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|/).reject{ |x| x.empty?}.map{|x| INVERSE_NUMBER[x] ? INVERSE_NUMBER[x] : x }.first
end

total = 0
File.readlines('1.input', chomp: true).each do |line|
  total += final_digit(line)
  puts "#{line} #{final_digit(line)}"
end

puts total
