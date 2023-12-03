def line_without_game_id(line)
  line.split(':').last
end

def game_draws(line)
  line_without_game_id(line).split(';')
end

def scan_draw(draw, minimum_cubes)
  draw.split(',').map {|x| x.split(" ")}.each do |value, colour|
    value = value.to_i
    if minimum_cubes[colour].nil?
      minimum_cubes[colour] = value
    else
      minimum_cubes[colour] = minimum_cubes[colour] >= value ? minimum_cubes[colour] : value
    end
  end
end

def scan_game_draws(line)
  minimum_cubes = {}
  game_draws(line).each do |draw|
    scan_draw(draw, minimum_cubes)
  end
  minimum_cubes.values.inject(:*)
end

total = 0
File.readlines('2.input', chomp: true).each do |line|
  total += scan_game_draws(line)
end

puts total