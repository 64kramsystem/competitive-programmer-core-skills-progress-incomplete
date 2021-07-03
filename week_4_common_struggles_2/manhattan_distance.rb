#!/usr/bin/env ruby

require 'stringio'

def parse_input(input)
  numbers_count = input.readline.strip.to_i

  numbers_count.times.map { input.readline.strip.split(' ').map(&:to_i) }
end

def compute_distance(point_a, point_b)
  a_x, a_y = point_a
  b_x, b_y = point_b

  (a_x - b_x).abs + (a_y - b_y).abs
end

def is_bounding_box_vertex?(reference_point_1, reference_point_2, test_point)
  rp1_x, rp1_y = reference_point_1
  rp2_x, rp2_y = reference_point_2
  tp_x, tp_y = test_point

  test_point == [[rp1_x, rp2_x].min, [rp1_y, rp2_y].min] ||
  test_point == [[rp1_x, rp2_x].max, [rp1_y, rp2_y].max]
end

def main(input, output)
  points = parse_input(input)

  most_distant_points = [0, 0]
  max_distance = 0

  0.upto(points.size - 1) do |new_point|
    more_distant_test_point = nil
    not_more_distant_test_points = []

    most_distant_points.each do |test_point|
      test_distance = compute_distance(points[test_point], points[new_point])

      if test_distance > max_distance
        max_distance = test_distance
        not_more_distant_test_points << more_distant_test_point if more_distant_test_point
        more_distant_test_point = test_point
      else
        not_more_distant_test_points << test_point
      end
    end

    if more_distant_test_point
      new_most_distant_points = [new_point, more_distant_test_point]

      not_more_distant_test_points.each do |test_point|
        if is_bounding_box_vertex?(new_point, more_distant_test_point, points[test_point])
          new_most_distant_points << test_point
        end
      end

      most_distant_points = new_most_distant_points

      puts "#{new_point + 1} #{more_distant_test_point + 1}"
    else
      puts "#{most_distant_points[0] + 1} #{most_distant_points[1] + 1}"
    end
  end
end

input = STDIN

if input.isatty
  input = StringIO.new <<~STR
    8
    5 5
    4 0
    7 3
    8 7
    10 8
    2 9
    8 6
    8 0
  STR
end

main(input, STDOUT)
