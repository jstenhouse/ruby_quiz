#!/usr/bin/env ruby

require 'optparse'

ZERO = [
  ' - ',
  '| |',
  '   ',
  '| |',
  ' - '
]

ONE = [
  '  ',
  ' |',
  '  ',
  ' |',
  '  '
]

TWO = [
  ' - ',
  '  |',
  ' - ',
  '|  ',
  ' - '
]

THREE = [
  ' - ',
  '  |',
  ' - ',
  '  |',
  ' - '
]

FOUR = [
  '   ',
  '| |',
  ' - ',
  '  |',
  '   '
]

FIVE = [
  ' - ',
  '|  ',
  ' - ',
  '  |',
  ' - '
]

SIX = [
  ' - ',
  '|  ',
  ' - ',
  '| |',
  ' - '
]

SEVEN = [
  ' - ',
  '  |',
  '   ',
  '  |',
  '   '
]

EIGHT = [
  ' - ',
  '| |',
  ' - ',
  '| |',
  ' - '
]

NINE = [
  ' - ',
  '| |',
  ' - ',
  '  |',
  ' - '
]

NUMBERS = {
  0 => ZERO,
  1 => ONE,
  2 => TWO,
  3 => THREE,
  4 => FOUR,
  5 => FIVE,
  6 => SIX,
  7 => SEVEN,
  8 => EIGHT,
  9 => NINE
}

############################################

def build_lcd_numbers(input)
  lcd_numbers = []
  input.chars.each_with_index do |char, index|
    lcd_numbers << NUMBERS[char.to_i]
  end
  lcd_numbers
end

def scale_horizontal(lcd_numbers, options)
  lcd_numbers.each do |array|
    array.each do |val|
      val.gsub!(/\s/, ' ' * options[:size])
      val.gsub!(/-/, '-' * options[:size])
    end
  end
end

def scale_vertical(lcd_numbers, options)
  lcd_numbers.each do |array|
    array.insert(1, array[1].dup)
    array.insert(4, array[4].dup)
  end
end

def scale_lcd_numbers(lcd_numbers, options)
  scale_horizontal(lcd_numbers, options)
  scale_vertical(lcd_numbers, options)
end

def print_lcd_numbers(lcd_numbers, options)
  scale_lcd_numbers(lcd_numbers, options)

  puts lcd_numbers.inspect
  
  num_rows    = ZERO.size * options[:size]
  num_columns = lcd_numbers.size * options[:size]

  num_rows.times do |row|
    num_columns.times do |column|
      print lcd_numbers[column][row]
      print '  ' * options[:size]
    end
    puts
  end
end

############################################

options = {
  :size => 2,
}

OptionParser.new do |opts|
  opts.banner = 'usage: lcd_numbers.rb [options] number'

  opts.on('-s', '--size [size]', 'size of digits') do |size|
    options[:size] = size.to_i
  end
end.parse!

unless ARGV.empty?
  lcd_numbers = build_lcd_numbers(ARGV[0])
  print_lcd_numbers(lcd_numbers, options)
end
