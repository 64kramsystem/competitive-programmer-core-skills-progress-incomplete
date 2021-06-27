#!/usr/bin/env ruby

STDIN.readline();

input_vals = STDIN.readline.split(" ").map(&:to_i);

max_positions = []
max = 0

input_vals.each_with_index do |val, pos|
  if val > max
    max_positions = [pos]
    max = val
  elsif val == max && max_positions.size < 3
    max_positions << pos
  end
end

if max_positions.size == 1
  input_vals.delete_at(max_positions[0]);
else
  input_vals.delete_at(max_positions[2]);
end

output = input_vals.map(&:to_s).join(" ")

print output
