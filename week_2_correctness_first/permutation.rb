#!/usr/bin/env ruby

require 'stringio'

def read_input(input)
  order = input.readline.to_i

  1.upto(order).each_with_object([]) do |_, matrix|
    matrix << input.readline.split(' ').map(&:to_i)
  end
end

def permutations(sequence, start_position = 0, &block)
  if start_position == sequence.size
    yield sequence
    return
  end

  start_position.upto(sequence.size - 1) do |new_position|
    sequence[start_position], sequence[new_position] = sequence[new_position], sequence[start_position]

    permutations(sequence, start_position + 1, &block)

    sequence[start_position], sequence[new_position] = sequence[new_position], sequence[start_position]
  end
end

# This has a complexity of (n * n!), due to the internal sum cycle. It can be reduced to (n!) by merging
# the sum logic inside the permutations routine, but this hurts readability.
#
def main(input, output)
  matrix = read_input(input)
  sequence = 1.upto(matrix.size).to_a

  cheapest_permutation = nil
  cheapest_permutation_value = nil

  permutations(sequence) do |permutation|
    value = permutation.each_cons(2).inject(0) do |sum, (i, j)|
      # WATCH OUT! The input is 1-based
      #
      sum + matrix[i - 1][j - 1]
    end

    # puts "#{permutation} => #{value}"

    if cheapest_permutation_value.nil? || value < cheapest_permutation_value
      cheapest_permutation = permutation.dup
      cheapest_permutation_value = value
    end
  end

  puts cheapest_permutation.join(' ')
end

input = STDIN

# input = StringIO.new("\
# 9
# 0 1 1 1 0 1 1 1 1
# 1 0 1 1 1 0 1 1 1
# 1 1 0 1 1 1 0 1 1
# 1 1 1 0 1 1 1 0 1
# 0 1 1 1 0 1 1 1 1
# 1 0 1 1 1 0 1 1 1
# 1 1 0 1 1 1 0 1 1
# 1 1 1 0 1 1 1 0 1
# 0 1 1 1 0 1 1 1 1
# ")

main(input, STDOUT)
