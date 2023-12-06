#!/usr/bin/env ruby -w

input = File.open(ARGV[0])
times = input.readline.scan(/\d+/).map(&:to_i)
distances = input.readline.scan(/\d+/).map(&:to_i)

# first puzzle
first = times.zip(distances).map do |(t, d)|
  f = ->(x) { x * x - t * x + d }

  delta = t**2 - 4 * d
  x1 = ((t - Math.sqrt(delta)) / 2).ceil
  x2 = ((t + Math.sqrt(delta)) / 2).floor

  x1 += 1 if f.call(x1).zero?
  x2 -= 1 if f.call(x2).zero?

  (x1..x2).size
end.reduce(:*)

puts first
