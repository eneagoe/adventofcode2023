#!/usr/bin/env ruby -w

space = []
empty_lines = []

File.open(ARGV[0]).readlines.each_with_index do |line, i|
  c = line.chomp.chars

  space << c.dup
  empty_lines << i if c.all?  { _1 == '.' }
end

n = space.size
m = space[0].size

# expand columns
empty_cols = (0...m).select do |j|
  (0...n).all? { space[_1][j] == '.' }
end

first = 0
second = 0
m = space[0].size

galaxies = []
(0...n).each do |i|
  (0...m).each do |j|
    galaxies << [i, j] if space[i][j] == '#'
  end
end

galaxies.combination(2).each do |from, to|
  start = [from[0], to[0]].min
  stop = [from[0], to[0]].max
  x = (from[0] - to[0]).abs
  empty_space = empty_lines.count { _1.between?(start + 1, stop - 1) }
  first += x + empty_space
  second += x + empty_space * 999_999

  y = (from[1] - to[1]).abs
  start = [from[1], to[1]].min
  stop = [from[1], to[1]].max

  empty_space = empty_cols.count { _1.between?(start + 1, stop - 1) }
  first += y + empty_space
  second += y + empty_space * 999_999
end

puts first
puts second
