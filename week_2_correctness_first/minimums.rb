#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  input.readline

  input.readline.split(' ').map(&:to_i)
end

def main_slow(input, output)
  array = parse_input(input)

  partial_sums = 1.upto(array.size).map do |i|
    array.each_cons(i).inject(0) { |sum, arr| sum + arr.min }
  end

  total_sum = partial_sums.inject(&:+)

  puts total_sum
end

# Performant enough solution (approx. O(n²)).
# By iterating the subarrays in a specific order (outer loop = all the subarrays starting with the current
# element), we can reuse the previous subarray minimum.
# If we used a sliding window approach (outer loop = all the subarrays of the current size), we couldn't
# reuse if the discarded element was the minimum (since knowledge of the elements inside the subarray
# is now required).
#
def main(input, output)
  array = parse_input(input)

  total_sum = 0

  0.upto(array.size - 1) do |reference|
    total_sum += array[reference]
    previous_min = array[reference]

    (reference + 1).upto(array.size - 1) do |next_i|
      next_ = array[next_i]

      if next_ < previous_min
        previous_min = next_
      end

      total_sum += previous_min
    end
  end

  puts total_sum
end

input = STDIN

# input = StringIO.new("4
# " + Array.new(20) { rand(10) }.join(' '))
# main_slow(StringIO.new(input.string), STDOUT)

main(input, STDOUT)
