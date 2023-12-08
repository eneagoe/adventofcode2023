#!/usr/bin/env ruby -w

cards = %w[A K Q T 9 8 7 6 5 4 3 2 J]
values = Hash[cards.reverse.zip((1..cards.size))]

hand_value = lambda do |hand|
  c = hand.chars
  groups = c.group_by(&:itself)

  rank = [1] + c.map { values[_1] } # high card

  rank = [7, *c.map { values[_1] }] if groups.count == 1 # 5 of a kind

  rank = [6, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 4] # 4 of a kind

  rank = [5, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [2, 3] # full house

  rank = [4, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 1, 3] # three of a kind

  rank = [3, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 2, 2] # two pairs

  rank = [2, *c.map { values[_1] }] if groups.map { _1[1].size }.sort == [1, 1, 1, 2] # a pair

  jokers = hand.count("J")

  if jokers == 4
    rank[0] = 7 # can make 5 of a kind
  elsif jokers == 3
    sizes = Set[*c].size
    if sizes == 2
      rank[0] = 7
    else
      rank[0] = 6 # full house, can make 4 of a kind
    end
  elsif jokers == 2
    sizes = Set[*c].size
    if sizes == 2
      rank[0] = 7
    elsif sizes == 3
      rank[0] = 6 # can make 4 of a kind
    else
      rank[0] = 4 # can make 3 of a kind
    end
  elsif jokers == 1
    case groups.map { _1[1].size }.sort
    when [1, 4]
      rank[0] = 7
    when [1, 1, 3]
      rank[0] = 6
    when [1, 2, 2]
      rank[0] = 5
    when [1, 1, 1, 2]
      rank[0] = 4
    else
      rank[0] = 2
    end
  end

  rank
end

hands = File.open(ARGV[0]).readlines.map do |line|
  /(?<hand>\w+)\s+(?<bid>\d+)/ =~ line

  [hand, bid.to_i]
end

# second puzzle
puts hands.sort_by { hand_value.call(_1[0]) }.map(&:last).zip(1..hands.size).map { |(a, b)| a * b }.reduce(:+)
