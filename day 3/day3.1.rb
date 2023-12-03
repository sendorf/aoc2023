def processed_line(line)
  processed_line = { 
    "numbers" => [],
    "symbols" => {
      "positions" => []
    }
  }
  line.chars.each_with_index do | char, index |
    next if is_dot?(char)

    if is_symbol?(char)
      processed_line["symbols"]["positions"] << index
    else
      if index == 0
        create_number(processed_line, char, index)
      elsif is_number?(line[index - 1])
        add_to_number(processed_line, char, index)
      else
        create_number(processed_line, char, index)
      end
    end
  end
  processed_line
end

def create_number(processed_line, char, index)
  processed_line["numbers"] << { "positions" => [index], "value" => char, "counted" => false }
end

def add_to_number(processed_line, char, index)
  number = processed_line["numbers"].last
  number["positions"] << index
  number["value"] += char
end

def is_number?(char)
  char.scan(/\d/).any?
end

def is_symbol?(char)
  !is_number?(char) && !is_dot?(char)
end

def is_dot?(char)
  char.scan(/\./).any?
end

def contacts_a_symbol?(position, symbols_positions)
  return symbols_positions.include?(position) if position == 0
  symbols_positions.include?(position - 1) || symbols_positions.include?(position) || symbols_positions.include?(position + 1)
end

def valid_numbers(processed_line, processed_previous_line)
  symbols_positions = processed_line["symbols"]["positions"] + processed_previous_line["symbols"]["positions"]
  valid_numbers_for(processed_line, symbols_positions) + valid_numbers_for(processed_previous_line, symbols_positions)
end

def valid_numbers_for(line, symbols_positions)
  valid_numbers = []
  line["numbers"].each do |number|
    valid = false
    number["positions"].each do |position|
      break if valid
      valid = contacts_a_symbol?(position, symbols_positions)
    end
    if valid && number["counted"] == false
      valid_numbers << number["value"].to_i
      number["counted"] = true
      next
    end
  end
  valid_numbers
end

processed_previous_line = { 
  "numbers" => [],
  "symbols" => {
    "positions" => []
  }
}
total = 0
File.readlines('3.input', chomp: true).each do |line|
  processed_line = processed_line(line)
  total += valid_numbers(processed_line, processed_previous_line).sum
  processed_previous_line = processed_line
end

puts total
