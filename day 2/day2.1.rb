CUBES_CONFIGURATION = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

def game_id(line)
  game_text_id = line.split(':').first
  game_text_id.scan(/\d+/).first.to_i
end

def line_without_game_id(line)
  line.split(':').last
end

def game_draws(line)
  line_without_game_id(line).split(';')
end

def scan_draw(draw)
  possible = true
  draw.split(',').map {|x| x.split(" ")}.each do |value, colour|
    break if !possible
    possible = CUBES_CONFIGURATION[colour] >= value.to_i
  end
  possible
end

def scan_game_draws(line)
  possible = true
  game_draws(line).each do |draw|
    break if !possible
    possible = scan_draw(draw)
  end
  possible
end

def process_line(line)
  scan_game_draws(line) ? game_id(line) : 0
end

total = 0
File.readlines('2.input', chomp: true).each do |line|
  total += process_line(line)
end

puts total