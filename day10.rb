#!/usr/bin/env ruby -w

start = [0, 0]
moves = {
  '|' => [[-1, 0], [1, 0]],
  '-' => [[0, -1], [0, 1]],
  'L' => [[-1, 0], [0, 1]],
  'J' => [[-1, 0], [0, -1]],
  '7' => [[0, -1], [1, 0]],
  'F' => [[1, 0], [0, 1]],
  '.' => [[0, 0]]
}

grid = File.open(ARGV[0]).readlines.map.with_index do |line, i|
  chars = line.chomp.chars
  j = chars.index('S')
  start = [i, j] if j

  chars
end

# first puzzle
q = []
max_distance = 0
visited = Array.new(grid.size) { Array.new(grid[0].size, 0) }
visited[start[0]][start[1]] = 1
polygon = []
polygon << [start[0].to_f, start[1].to_f] unless '|-'.include? grid[start[0]][start[1]]

if start[0].positive? && '|7F'.include?(grid[start[0] - 1][start[1]])
  q << [start[0] - 1, start[1], 2]
elsif start[0] < grid.size - 1 && '|JL'.include?(grid[start[0] + 1][start[1]])
  q << [start[0] + 1, start[1], 2]
elsif start[1].positive? && 'LF-'.include?(grid[start[0]][start[1] - 1])
  q << [start[0], start[1] - 1, 2]
elsif start[1] < grid[0].size - 1 && '-7J'.include?(grid[start[0]][start[1] + 1])
  q << [start[0], start[1] + 1, 2]
end

until q.empty?
  x, y, distance = q.shift
  visited[x][y] = distance
  polygon << [x.to_f, y.to_f] unless '|-'.include?(grid[x][y])

  moves[grid[x][y]].each do |dx, dy|
    i = x + dx
    j = y + dy

    q << [i, j, distance + 1] unless visited[i][j].positive?
  end

  max_distance = [distance, max_distance].max
end

puts max_distance

# 2nd puzzle
Point = Struct.new(:x, :y) do
  def shoelace(other)
    x * other.y - y * other.x
  end
end

class Polygon
  def initialize(*coords)
    @points = coords.map { |c| Point.new(*c) }
  end

  def area
    points = @points + [@points.first]

    points.each_cons(2).sum { |p1, p2| p1.shoelace(p2) }.abs.fdiv(2)
  end
end

# shoelace formula https://en.wikipedia.org/wiki/Shoelace_formula
polygon_area = Polygon.new(*polygon).area

# use Pick's theorem https://en.wikipedia.org/wiki/Pick%27s_theorem
puts polygon_area + 1 - max_distance / 2
