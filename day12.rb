#!/usr/bin/env ruby -w

$first = 0

# very slow, but works for the 1st puzzle
# would not work at all for 2nd puzzle
def backtrack(step, current, unknowns, patterns)
  if step == unknowns.size
    $first += 1 if current.scan(/\#+/).map(&:size) == patterns
  else
    ['.', '#'].each do |c|
      current[unknowns[step]] = c
      backtrack(step + 1, current, unknowns, patterns)
    end
  end
end

File.open(ARGV[0]).readlines.each do |line|
  springs, pattern = line.chomp.split(/\s+/)
  patterns = pattern.split(/,/).map(&:to_i)
  unknowns = (0...springs.length).find_all { |i| springs[i] == '?' }

  backtrack(0, springs, unknowns, patterns)
end

# first puzzle
puts $first
