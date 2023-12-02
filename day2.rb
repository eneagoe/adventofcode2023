#!/usr/bin/env ruby -w

limits = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}
first = 0
second = 0

File.open(ARGV[0]).readlines.each do |line|
  /^Game\s+(?<id>\d+):\s+(?<game>.*)$/ =~ line

  max = {
    "red" => 1,
    "green" => 1,
    "blue" => 1
  }

  rounds = game.split(/;/)

  valid = rounds.all? do |round|
    round.split(/,/).all? do |hand|
      /\s*(?<cubes>\d+)\s+(?<color>\w+)/ =~ hand

      limits[color] >= cubes.to_i
    end
  end

  rounds.each do |round|
    round.split(/,/).all? do |hand|
      /\s*(?<cubes>\d+)\s+(?<color>\w+)/ =~ hand

      max[color] = [max[color], cubes.to_i].max
    end
  end

  first += id.to_i if valid
  second += max.values.reduce(:*)
end

# first puzzle
puts first

# second puzzle
puts second
