#!/usr/bin/env ruby

require 'stringio'

MAX_VALUE = 100_000

def parse_input(input)
  numbers_count = input.readline.strip.to_i

  numbers_count.times.map { input.readline.strip.split(' ').map(&:to_i) }
end

def main(input, output)
  intervals = parse_input(input)

  # Notice that we decrement one unit after the r-value (think about [1,1]). For simplicity, we use
  # an extra entry (which is not read); it can probably be made unnecessary with a conditional or so.
  #
  count = [0] * (MAX_VALUE + 1)
  intervals.each { |l, r| count[l - 1] += 1; count[r - 1 + 1] -= 1 }

  count.each_with_index.inject(0) do |current_sum, (i_val, i)|
    current_sum += i_val

    if current_sum > 0
      puts "#{i + 1} #{current_sum}"
    end

    current_sum
  end
end

input = STDIN

if input.isatty
  input = StringIO.new <<~STR
  1
  1 100000
  STR
end

main(input, STDOUT)
