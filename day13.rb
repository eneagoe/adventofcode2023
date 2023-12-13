#!/usr/bin/env ruby -w

def score(grid)
  n = grid.size
  m = grid[0].size

  candidates = (0...n - 1).select { |i| grid[i] == grid[i + 1] }
  candidates.each do |i|
    d = [i + 1, n - i - 1].min

    if (0...m).all? do |j|
      top = (i..).step(-1).take(d).map { grid[_1][j] }
      bottom = (i + 1..).take(d).map { grid[_1][j] }

      top == bottom
    end
      return 100 * (i + 1)
    end
  end

  grid = grid.transpose

  candidates = (0...m - 1).select { |i| grid[i] == grid[i + 1] }
  candidates.each do |i|
    d = [i + 1, m - i - 1].min
    if (0...n).all? do |j|
      top = (i..).step(-1).take(d).map { grid[_1][j] }
      bottom = (i + 1..).take(d).map { grid[_1][j] }

      top == bottom
    end
      return i + 1
    end
  end

  0
end

first = 0

current = []
File.open(ARGV[0]).readlines.each do |line|
  line.chomp!

  if line.empty?
    first += score(current)
    current = []
  else
    current << line.chars
  end
end
first += score(current)

# first puzzle
puts first
