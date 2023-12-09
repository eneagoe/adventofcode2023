#!/usr/bin/env ruby -w

first = 0
second = 0

File.open(ARGV[0]).readlines.each do |line|
  values = line.split(/\s+/).map(&:to_i)
  first_prediction = values[0]
  last_prediction = values[-1]
  sign = -1

  until values.all?(&:zero?)
    values = values.each_cons(2).map { |(a, b)| b - a }

    first_prediction += values[0] * sign
    last_prediction += values[-1]
    sign *= -1
  end

  first += last_prediction
  second += first_prediction
end

# first puzzle
puts first

# second puzzle
puts second
