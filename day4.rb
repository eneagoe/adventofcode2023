#!/usr/bin/env ruby -w

first = 0

File.open(ARGV[0]).readlines.each do |line|
  _, wins, owns = line.split(/[:|]/)
  winners = wins.strip.split(/\s+/).map(&:to_i)
  owned = owns.strip.split(/\s+/).map(&:to_i)
  won = winners & owned
  first += 2**(won.size - 1) if won.size.positive?
end

# first puzzle
puts first

# second puzzle
