#!/usr/bin/env ruby

require 'stringio'

CENTRAL_RATIOS = {
  3 => Rational(8, 9),
  2 => Rational(5, 6),
  1 => Rational(2, 3),
}

# width => remaining_squares => kings
REMAINING_FILLS = {
  1 => {
    1 => 0,
    2 => 1
  },
  2 => {
    1 => 1,
    2 => 3,
  }
}

def parse_input(input)
  input.readline.split(' ').map(&:to_i)
end

def count_central_kings(width, height)
  remaining_columns = width % 3
  remaining_rows = height % 3

  central_kings = ((width - remaining_columns) * (height - remaining_rows) * CENTRAL_RATIOS.fetch(3)).to_i

  [central_kings, remaining_columns, remaining_rows]
end

def count_stripe_kings(width, length)
  return 0 if width == 0

  remaining_squares = length % 3

  centrally_filled_kings = (width * (length - remaining_squares) * CENTRAL_RATIOS.fetch(width)).to_i

  if remaining_squares == 0
    centrally_filled_kings
  else
    centrally_filled_kings + REMAINING_FILLS[width][remaining_squares]
  end
end

# Relatively uncomplicated. We first count the squares of the internal board whose sides are multiples of 3.
# The computation of the remaining sides depends only on the remainders (% 3) of the width/height; there are
# a handful of cases (see REMAINING_FILLS). The smallest side must be picked first, because it fills
# worse (there is only one case for this - widths 1,2).
# This logic is general, however, for cases where the two remainders are the same, they can be treated as
# a single, summed, stripe.
#
def main(input, output)
  width, height = parse_input(input)

  current_kings, remaining_columns, remaining_rows = count_central_kings(width, height)

  first_stripe, second_stripe = [[remaining_columns, height], [remaining_rows, width]].sort_by { |(width, _) | width }

  current_kings += count_stripe_kings(first_stripe[0], first_stripe[1])
  current_kings += count_stripe_kings(second_stripe[0], second_stripe[1] - first_stripe[0])

  output.puts current_kings
end

input = STDIN

# input = StringIO.new("5 3")

main(input, STDOUT)
