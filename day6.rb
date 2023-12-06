#!/usr/bin/env ruby -w

input = File.open(ARGV[0])

first = input.readline
racetime = first.gsub(/\D+/, '').to_i
times = first.scan(/\d+/).map(&:to_i)
second = input.readline
record = second.gsub(/\D+/, '').to_i
distances = second.scan(/\d+/).map(&:to_i)

ways_to_win = lambda do |t, d|
  f = ->(x) { x * x - t * x + d }

  delta = t**2 - 4 * d
  x1 = ((t - Math.sqrt(delta)) / 2).ceil
  x2 = ((t + Math.sqrt(delta)) / 2).floor

  x1 += 1 if f.(x1).zero?
  x2 -= 1 if f.(x2).zero?

  (x1..x2).size
end

# first puzzle
puts times.zip(distances).map { ways_to_win.(*_1) }.reduce(:*)

# second puzzle
puts ways_to_win.call(racetime, record)
