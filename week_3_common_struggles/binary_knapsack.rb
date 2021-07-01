#!/usr/bin/env ruby

require 'stringio'

def permutations(sequence, start_position = 0, &block)
  if start_position == sequence.size
    yield sequence
    return # technically optional, but confusing if omitted
  end

  start_position.upto(sequence.size - 1) do |new_position|
    sequence[start_position], sequence[new_position] = sequence[new_position], sequence[start_position]

    permutations(sequence, start_position + 1, &block)

    # By restoring the sequence, we don't need to use a temporary array.
    sequence[start_position], sequence[new_position] = sequence[new_position], sequence[start_position]
  end
end

# Returns [weight, elements_data], where elements_data is composed by [weight, value].
#
def parse_input(input)
  count, weight = input.readline.strip.split(' ').map(&:to_i)

  elements_data = 1.upto(count).map do
    input.readline.strip.split(' ').map(&:to_i)
  end

  [weight, elements_data]
end

def find_best_combo(max_weight, elements_data)
  best_combo = []
  max_value = 0

  elements_data = elements_data.select { |weight, _| weight <= max_weight }

  # AAAARGH!! This is factorial!!

  permutations(elements_data) do |permutation|
    current_weight = 0
    current_value = 0
    current_combo = []

    permutation.each do |weight, value|
      if current_weight + weight > max_weight
        break
      end

      current_weight += weight
      current_value += value

      current_combo << [weight, value]
    end

    if current_value > max_value
      max_value = current_value
      best_combo = current_combo
    end
  end

  best_combo
end

def remove_best_combo(elements_data, best_combo)
  elements_data - best_combo
end

def main(input, output)
  weight, elements_data = parse_input(input)

  max_value = 0

  0.upto(Math.log2(weight).ceil) do |i|
    current_weight = weight & (2 ** i)

    if current_weight != 0
      best_combo = find_best_combo(current_weight, elements_data)
      elements_data -= best_combo
      max_value += best_combo.map { |_, v| v }.inject(&:+) || 0
    end
  end

  puts max_value
end

input = STDIN

input = StringIO.new("\
28 68335
32 14
64 557
16 902
65536 12
1 773
64 448
1024 498
64 34
131072 332
8 775
32 673
64 795
2048 130
2048 239
8 603
2048 626
2 54
64 278
4 745
64 947
2048 929
16384 589
1024 890
256 596
8192 172
1 798
16384 116
8 613
4096 199
65536 385
8 870
32 849
256 323
16 977
2048 990
262144 456
262144 592
1 294
131072 852
131072 360
262144 318
4096 288
512 759
4 891
16384 330
131072 679
4096 319
16384 657
256 738
2 972
512 875
256 120
8 519
8192 727
4 838
262144 443
4096 872
512 218
8192 779
4 224
16 417
4 914
256 587
16384 832
65536 891
16384 180
16 355
128 369
8192 949
8 801
1024 366
2048 922
8 642
256 858
512 461
16384 839
8 957
4 371
65536 821
1024 103
512 568
8 692
1024 118
4 113
8192 375
4 948
512 154
16384 291
16 846
64 126
4 833
1 321
8 732
4096 248
8192 935
262144 431
65536 847
262144 19
16 890
16384 727
")

main(input, STDOUT)
