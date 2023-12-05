#!/usr/bin/env ruby -w

class Range
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end
end

input = File.open(ARGV[0])

# read seeds
seeds = []
input.readline.scan(/\d+/).map(&:to_i).each_slice(2) do |start, size|
  seeds << (start..start + size - 1)
end

input.readline

7.times do |_round|
  input.readline # skip header

  processed = Set.new
  new_seeds = []

  while !input.eof? && ((line = input.readline) !~ /^\s*$/)
    destination, source, size = line.split(/\s+/).map(&:to_i)

    from = (source..source + size - 1)
    destination = (destination..destination + size - 1)
    seeds.each do |seed|
      if processed.include?(seed)
        new_seeds << seed
        next
      end

      if from.overlaps?(seed)
        processed << seed

        if from.cover?(seed.first)
          start = destination.first + seed.first - from.first
          stop = start + seed.last - seed.first

          if seed.cover?(from.last + 1)
            new_seeds << (from.last + 1..seed.last)
            processed << new_seeds
            stop = destination.first + from.last - from.first
          end

          new_seeds << (start..stop)
          processed << (start..stop)
        else
          new_seeds << (seed.first..from.first - 1)

          if from.cover?(seed.last)
            new_seeds << (destination.first..destination.first + seed.last - from.first)
            processed << (destination.first..destination.first + seed.last - from.first)
          else
            new_seeds << (destination.first..destination.first + from.last - from.first)
            processed << (destination.first..destination.first + from.last - from.first)
            new_seeds << (from.last + 1..seed.last)
          end
        end
      else
        new_seeds << seed
      end
    end
    seeds = new_seeds.dup
    new_seeds = []
  end
end

puts seeds.map(&:first).min
