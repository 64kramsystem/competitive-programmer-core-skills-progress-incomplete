#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  input.readline.strip.split(' ').map(&:to_i)
end

def main(input, output)
  x, y = parse_input(input)

  puts (x.to_f / y).ceil
end

input = STDIN

# input = StringIO.new("1 -2
# ")

main(input, STDOUT)
