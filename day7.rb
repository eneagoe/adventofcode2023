#!/usr/bin/env ruby -w

cards = %w[A K Q J T 9 8 7 6 5 4 3 2]
values = Hash[cards.reverse.zip((1..cards.size))]

hand_value = lambda do |hand|
  c = hand.chars
  groups = c.group_by(&:itself)

  return [7, values[c[0]]] if groups.count == 1 # 5 of a kind

  return [6, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 4] # 4 of kind

  return [5, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [2, 3] # full house

  return [4, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 1, 3] # three of a kind

  return [3, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 2, 2] # two pairs

  return [2, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 1, 1, 2] # a pair

  [1] + c.map { values[_1] } # high card
end

hands = File.open(ARGV[0]).readlines.map do |line|
  /(?<hand>\w+)\s+(?<bid>\d+)/ =~ line

  [hand, bid.to_i]
end

# first puzzle
puts hands.sort_by { hand_value.call(_1[0]) }.map(&:last).zip(1..hands.size).map { |(a, b)| a * b }.reduce(:+)
