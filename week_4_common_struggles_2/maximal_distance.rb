#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  numbers_count = input.readline.strip.to_i

  numbers_count.times.map { input.readline.strip.to_i }
end

def main(input, output)
  values = parse_input(input)

  min_value_i, max_value_i = 0, 0

  values.each_with_index do |value, value_i|
    if value < values[min_value_i]
      min_value_i = value_i
    elsif value > values[max_value_i]
      max_value_i = value_i
    end

    # The order of the pair of numbers is not specified, although, in the example, the lowest `i` is
    # printed first.
    puts [min_value_i, max_value_i].map { |i| i + 1 }.sort.join(' ')
  end
end

input = STDIN

if input.isatty
  input = StringIO.new(<<~STR
    5
    3
    2
    1
    50
    49
  STR
  )
end

main(input, STDOUT)
