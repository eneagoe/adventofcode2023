#!/usr/bin/env ruby -w

limits = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}
first = 0

File.open(ARGV[0]).readlines.each do |line|
  /^Game\s+(?<id>\d+):\s+(?<game>.*)$/ =~ line

  valid = game.split(/;/).all? do |round|
    round.split(/,/).all? do |hand|
      /\s*(?<cubes>\d+)\s+(?<color>\w+)/ =~ hand

      limits[color] >= cubes.to_i
    end
  end

  first += id.to_i if valid
end

# first puzzle
puts first

# second puzzle
