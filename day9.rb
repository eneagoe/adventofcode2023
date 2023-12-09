#!/usr/bin/env ruby -w

first = 0

File.open(ARGV[0]).readlines.each do |line|
  values = line.split(/\s+/).map(&:to_i)
  prediction = values[-1]

  until values.all?(&:zero?)
    values = values.each_cons(2).map { |(a, b)| b - a }
    prediction += values[-1]
  end

  first += prediction
end

puts first
