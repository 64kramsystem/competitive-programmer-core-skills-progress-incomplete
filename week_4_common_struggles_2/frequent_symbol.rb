#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  string_chars = input.readline.strip.chars
  queries = input.readline.strip.to_i
  subarrays = 1.upto(queries).map { input.readline.strip.split(' ').map(&:to_i) }

  [string_chars, subarrays]
end

def find_frequency_table(string_chars, start, end_, frequency_table)
  string_chars[(start - 1)..(end_ - 1)].each do |char|
    char_i = char.ord - 'a'.ord
    frequency_table[char_i] += 1
  end

  frequency_table
end

def find_most_frequent_char(frequency_table)
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

  subarrays = subarrays
    .each_with_index
    .map { |subarray, i| [subarray, i] }
    .sort_by { |subarray, _| subarray }

  result = [nil] * subarrays.size

  subarrays.inject([0, 0]) do |(previous_start, previous_end, previous_frequency_table), ((start, end_), subarray_i)|
    if start != previous_start
      previous_frequency_table = [0] * 26
      shorter_start = start
    else
      shorter_start = previous_end + 1
    end
# print "I:#{subarray_i} S:#{start} E:#{end_} PFT:#{previous_frequency_table} => "
    current_frequency_table = find_frequency_table(string_chars, shorter_start, end_, previous_frequency_table)
# puts "CFT:#{current_frequency_table}"
    most_frequent_char = find_most_frequent_char(current_frequency_table)

    result[subarray_i] = most_frequent_char

    [start, end_, current_frequency_table]
  end

  result.each { |char| output.puts char }
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
