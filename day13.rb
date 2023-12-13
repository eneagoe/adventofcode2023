#!/usr/bin/env ruby -w

def score(grid, reflection)
  n = grid.size
  m = grid[0].size

  candidates = (0...n - 1).select { |i| grid[i] == grid[i + 1] }
  candidates.each do |i|
    next if reflection == "H#{i}"

    d = [i + 1, n - i - 1].min

    if (0...m).all? do |j|
      top = (i..).step(-1).take(d).map { grid[_1][j] }
      bottom = (i + 1..).take(d).map { grid[_1][j] }

      top == bottom
    end
      return [100 * (i + 1), "H#{i}"]
    end
  end

  grid = grid.transpose

  candidates = (0...m - 1).select { |i| grid[i] == grid[i + 1] }
  candidates.each do |i|
    next if reflection == "V#{i}"

    d = [i + 1, m - i - 1].min
    if (0...n).all? do |j|
      top = (i..).step(-1).take(d).map { grid[_1][j] }
      bottom = (i + 1..).take(d).map { grid[_1][j] }

      top == bottom
    end
      return [i + 1, "V#{i}"]
    end
  end

  [0, '']
end

def score_smudge(grid, reflection)
  n = grid.size
  m = grid[0].size

  (0...n).each do |i|
    (0...m).each do |j|
      c = grid[i][j]
      grid[i][j] = if c == '.'
                     '#'
                   else
                     '.'
                   end

      candidate_score = score(grid.map(&:clone), reflection)[0]

      return candidate_score unless candidate_score.zero?

      grid[i][j] = c
    end
  end

  0
end

first = 0
second = 0

current = []
File.open(ARGV[0]).readlines.each do |line|
  line.chomp!

  if line.empty?
    s, reflection = score(current, '')
    first += s
    second += score_smudge(current, reflection)
    current = []
  else
    current << line.chars
  end
end

s, relection = score(current, '')
first += s
second += score_smudge(current, relection)

# first puzzle
puts first

# second puzzle
puts second
