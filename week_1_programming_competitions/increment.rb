#!/usr/bin/env ruby

def main(input, output)
  chars_count = 0
  last_char = nil
  only_nines = true

  loop do
    begin
      read_char = input.readchar

      if read_char.chomp == ''
        break
      elsif read_char == '9'
        last_char = read_char
        chars_count += 1
      else
        last_char = read_char
        chars_count += 1
        only_nines = false
      end
    rescue EOFError
      break
    end
  end

  chars_count += 1 if only_nines

  output.puts(chars_count)
end

main(STDIN, STDOUT)
