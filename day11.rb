#!/usr/bin/env ruby -w

space = []

File.open(ARGV[0]).readlines.each do |line|
  c = line.chomp.chars

  space << c.dup
  # expand lines
  space << c.dup if c.all? { _1 == "." }
end

n = space.size
j = 0

# expand columns
while j < space[0].size
  if (0...n).all? { space[_1][j] == "." }
    (0...n).each do
      space[_1].insert(j, ".")
    end

    j += 1
  end

  j += 1
end

# first puzzle
first = 0
m = space[0].size

galaxies = []
(0...n).each do |i|
  (0...m).each do |j|
    galaxies << [i, j] if space[i][j] == "#"
  end
end

galaxies.combination(2).each do |from, to|
  x = (from[0] - to[0]).abs
  y = (from[1] - to[1]).abs

  first += x + y
end

puts first
