#!/usr/bin/env ruby

def main(input, output)
  x, y, z = input.readline.split(' ').map(&:to_i)

  last_val = 0

  # The series has two possible values (for i >= 1):
  #
  # - nx - (n - 1)y
  # - nx - ny
  #
  # With i reaching large values, e.g. 10000, even with the minimum difference between x and y (-> 1),
  # e.g. x=2,y=1, the result is necessarily greater than the maximum allowed z (1000).
  #
  # There are edge cases, but this simple logic covers everything required.

  if z == last_val
    print 0
    return
  end

  1.upto(10000) do |i|
    if i % 2 == 1
      last_val += x
    else
      last_val -= y
    end

    if last_val == z
      print i
      return
    end
  end

  print -1
end

main(STDIN, STDOUT)
