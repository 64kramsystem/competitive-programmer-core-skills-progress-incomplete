#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  string_chars = input.readline.strip.chars
  queries = input.readline.strip.to_i
  subarrays = 1.upto(queries).map { input.readline.strip.split(' ').map(&:to_i) }

  [string_chars, subarrays]
end

def find_most_frequent_char(string_chars, start, end_)
  frequency_table = [0] * 26

  string_chars[(start - 1)..(end_ - 1)].each do |char|
    char_i = char.ord - 'a'.ord
    frequency_table[char_i] += 1
  end

  max_mfc_count = 0
  max_mfc_index = -1

  frequency_table.each_with_index do |char_frequency, char_index|
    if char_frequency >= max_mfc_count
      max_mfc_count = char_frequency
      max_mfc_index = char_index
    end
  end

  ('a'.ord + max_mfc_index).chr
end

def main(input, output)
  string_chars, subarrays = parse_input(input)

  subarrays.each do |start, end_|
    most_frequent_char = find_most_frequent_char(string_chars, start, end_)
    output.puts most_frequent_char
  end
end

input = STDIN

if input.isatty
  input = StringIO.new(<<~STR
    abba
    6
    1 1
    2 2
    1 2
    2 3
    1 1
    2 4
  STR
  )
end

main(input, STDOUT)
