#!/usr/bin/env ruby

sort_a_1 = {
  'A' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'T' => 10,
  'J' => 11,
  'Q' => 12,
  'K' => 13,
}

sort_a_13 = {
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'T' => 10,
  'J' => 11,
  'Q' => 12,
  'K' => 13,
  'A' => 14,
}

cards = STDIN.readline.split(" ")

if cards.map { |card| card[1] }.uniq.size != 1
  print 'NO'
  exit
end

sorted_cards_a_1 = cards.map { |card| sort_a_1.fetch(card[0]) }.sort

sorted_cards_a_1.each_cons(2).each_with_index do |(a, b), i|
  if b != a + 1
    break
  elsif i == 3
    print 'YES'
    exit
  end
end

sorted_cards_a_13 = cards.map { |card| sort_a_13.fetch(card[0]) }.sort

sorted_cards_a_13.each_cons(2).each_with_index do |(a, b), i|
  if b != a + 1
    break
  elsif i == 3
    print 'YES'
    exit
  end
end

print 'NO'
