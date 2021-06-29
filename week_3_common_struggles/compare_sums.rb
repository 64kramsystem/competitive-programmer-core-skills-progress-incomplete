#!/usr/bin/env ruby

require 'stringio'
require 'bigdecimal'
require 'bigdecimal/util'

def parse_input(input)
  input.readline

  values_a = input.readline.split(' ').map(&:to_d)
  values_b = input.readline.split(' ').map(&:to_d)

  [values_a, values_b]
end

# It's unclear if this would be considered cheating or not, as using decimals is exact but sidesteps
# the FP rounding issues entirely. Performance is also not mentioned.
#
def main(input, output)
  values_a, values_b = parse_input(input)

  sum_a = values_a.inject(&:+)
  sum_b = values_b.inject(&:+)

  operator =
    case
    when sum_a < sum_b then '<'
    when sum_a > sum_b then '>'
    else                    '='
    end

  puts "SUM(A)#{operator}SUM(B)"
end

input = STDIN

# input = StringIO.new("4
# 1.000 2.000 3.000
# 1.001 2.001 3.001
# ")

main(input, STDOUT)
