#!/usr/bin/env ruby -w

first = 0
second = 0

digits = Hash[%w[one two three four five six seven eight nine].zip(1..9)].merge(Hash[('1'..'9').zip(1..9)])
digit_re = Regexp.union(*digits.keys, /\d/)

File.open(ARGV[0]).readlines.each do |line|
  numbers = line.scan(/\d/)

  candidates = line.scan(/(?=(#{digit_re}))/).flatten

  first += begin
    digits[numbers[0]] * 10 + digits[numbers[-1]]
  rescue StandardError
    0
  end
  second += digits[candidates[0]] * 10 + digits[candidates[-1]]
end

# first puzzle
puts first

# second puzzle
puts second
