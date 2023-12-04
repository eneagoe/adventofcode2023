#!/usr/bin/env ruby -w

first = 0
cards = [1] * 500

n = File.open(ARGV[0]).readlines.each_with_index do |line, i|
  _, wins, owns = line.split(/[:|]/)
  winners = wins.strip.split(/\s+/).map(&:to_i)
  owned = owns.strip.split(/\s+/).map(&:to_i)
  won = winners & owned

  next unless won.size.positive?

  first += 2**(won.size - 1)
  (i + 1..i + won.size).each do |j|
    cards[j] += cards[i]
  end
end.size

# first puzzle
puts first

# second puzzle
puts cards[...n].sum
