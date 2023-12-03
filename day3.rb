#!/usr/bin/env ruby -w

first = 0
second = 0

symbols = Set.new
numbers = []
gears = []

File.open(ARGV[0]).readlines.each_with_index do |line, i|
  line.chomp!
  # add all the numbers on the current line, with the index where each starts
  numbers << line.enum_for(:scan, /(\d+)/).map { [Regexp.last_match.begin(0), Regexp.last_match(1)] }
  # add all the symbols & positions on current line
  line.enum_for(:scan, /([^\d.])/).each do
    symbols << [i, Regexp.last_match.begin(0)]
    gears << [i, Regexp.last_match.begin(0)] if Regexp.last_match(1) == '*'
  end
end

# first puzzle
numbers.each_with_index do |line, i|
  line.each do |j, number|
    if symbols.include?([i, j - 1]) ||
       symbols.include?([i, j + number.size]) ||
       [i - 1].product((j - 1..j + number.size).to_a).any? { symbols.include? _1 } ||
       [i + 1].product((j - 1..j + number.size).to_a).any? { symbols.include? _1 }
      first += number.to_i
    end
    (j - 1..j + 1)
  end
end

puts first

# second puzzle
gears.each do |(i, j)|
  candidates = numbers[i].select { |p, nr| p == j + 1 || p + nr.size == j }.map { _1.last.to_i }
  if i.positive?
    candidates.concat(numbers[i - 1].select { |p, nr| (p..p + nr.size).cover?(j) || p == j + 1 }.map { _1.last.to_i })
  end

  if i < numbers.size - 1
    candidates.concat(numbers[i + 1].select { |p, nr| (p..p + nr.size).cover?(j) || p == j + 1 }.map { _1.last.to_i })
  end

  second += candidates.first * candidates.last if candidates.size == 2
end

puts second
