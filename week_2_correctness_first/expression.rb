#!/usr/bin/env ruby

require 'stringio'

MULTIPLIERS = {
  '+' => 1,
  '-' => -1,
}

def sum_buffer(buffer, multiplier)
  multiplier * buffer.each_with_index.map { |val, i| val * 10 ** (buffer.size - i - 1) }.inject(&:+)
end

# This assignment is really odd. Given the small size of the string, and the lack of constraints, it's
# extremely easy, but it's not clear what the teacher had in mind, and what constitutes cheating.
# This is an attempt to solve it in what could be the intendedly more difficult way.
#
# Array#sum is not supported on the platform's Ruby version.
#
# Differently from the other assignments, this one terminates the strings with a new line.
#
def main(input, output)
  sum = 0
  current_buffer = []
  current_multiplier = MULTIPLIERS.fetch('+')

  input.each_char do |c|
    if c.strip == ''
      break
    elsif c == '+' || c == '-'
      sum += sum_buffer(current_buffer, current_multiplier)
      current_multiplier = MULTIPLIERS.fetch(c)
      current_buffer = []
    else
      current_buffer << c.to_i
    end
  end

  sum += sum_buffer(current_buffer, current_multiplier)

  puts sum
end

input = STDIN

# input = StringIO.new("1-2+3-4")

main(input, STDOUT)
