#!/usr/bin/env ruby

# With suggestion from the professor.

require 'stringio'

def parse_input(input)
  string_chars = input.readline.strip.chars
  queries = input.readline.strip.to_i
  subarrays = 1.upto(queries).map { input.readline.strip.split(' ').map(&:to_i) }

  [string_chars, subarrays]
end

def build_progressive_frequency_tables(string_chars)
  tables = Array.new(26) { [nil] * string_chars.size }

  string_chars.each_with_index do |char, i|
    tables.each do |table|
      if i == 0
        table[i] = 0
      else
        table[i] = table[i - 1]
      end
    end

    tables[char.ord - 'a'.ord][i] += 1
  end

  tables
end

def compute_occurrencies(frequency_table, start, end_)
  # Normalize
  start, end_ = start - 1, end_ - 1

  start_value = start == 0 ? 0 : frequency_table[start - 1]

  frequency_table[end_] - start_value
end

def main(input, output)
  string_chars, subarrays = parse_input(input)

  progressive_frequency_tables = build_progressive_frequency_tables(string_chars)

  subarrays.each do |(start, end_)|
    max_occurrences = 0
    best_char_i = nil

    progressive_frequency_tables.each_with_index do |frequency_table, char_i|
      occurrences = compute_occurrencies(frequency_table, start, end_)

      if occurrences >= max_occurrences
        best_char_i = char_i
        max_occurrences = occurrences
      end
    end

    puts ('a'.ord + best_char_i).chr
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
