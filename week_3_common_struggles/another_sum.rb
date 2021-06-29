#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  input.readline
  input.readline.strip.split(' ').map(&:to_i)
end

# The error of FP numbers is smaller for smaller number (in absolute value), so we sum separately in
# order to minimize the error.
#
def main(input, output)
  sequence = parse_input(input)

  sum_sequence = sequence.inject(&:+)
  sum_sequence_inverses = sequence.map { |x| 1.0 / x }.inject(&:+)

  puts sum_sequence + sum_sequence_inverses
end

input = STDIN

# input = StringIO.new("\
# 000
# -2 -3 1 2")

main(input, STDOUT)
