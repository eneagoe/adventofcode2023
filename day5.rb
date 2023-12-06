#!/usr/bin/env ruby -w

input = File.open(ARGV[0])

# read seeds
seeds = input.readline.scan(/\d+/).map(&:to_i)
mapping = Hash[seeds.zip(seeds)]

input.readline

7.times do
  input.readline

  while !input.eof? && ((line = input.readline) !~ /^\s*$/)
    destination, source, size = line.split(/\s+/).map(&:to_i)

    seeds.each do |seed|
      mapping[seed] = destination + seed - source if (source...source + size).cover?(seed)
    end
  end

  seeds = mapping.values
  mapping = Hash[seeds.zip(seeds)]
end

# first puzzle
puts mapping.values.min
