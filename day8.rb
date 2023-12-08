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

steps = 0
at = 'AAA'

while at != 'ZZZ'
  at = d[at][moves[steps % n]]
  steps += 1
end

# first puzzle
puts steps
