#!/usr/bin/env ruby -w

input = File.open(ARGV[0])
moves = input.readline.chomp.chars
input.readline

n = moves.size
d = {}

until input.eof
  line = input.readline
  /(?<from>\w+)\s+=\s+\((?<left>\w+),\s+(?<right>\w+)\)/ =~ line

  d[from] = {
    'L' => left, 'R' => right
  }
end

# first puzzle
steps = 0
at = 'AAA'

while at != 'ZZZ'
  at = d[at][moves[steps % n]]
  steps += 1
end

puts steps

# second puzzle
# this only works because the input is specially crafted: paths from locations
# ending in A to locations ending in Z are loops.
steps = 0
locations = d.keys.select { _1.end_with? 'A' }

locations.map! do |at|
  steps = 0

  until at.end_with?('Z')
    at = d[at][moves[steps % n]]
    steps += 1
  end

  steps
end

puts locations.reduce(:lcm)
