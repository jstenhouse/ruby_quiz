#!/usr/bin/env ruby

require 'optparse'

ROWS = 5
COLS = 3

NUMBERS = {
  '0' => [
    ' — ',
    '| |',
    '   ',
    '| |',
    ' — '
  ],

  '1' => [
    '—  ',
    ' | ',
    ' | ',
    ' | ',
    '———'
  ],

  '2' => [
    ' — ',
    '  |',
    ' — ',
    '|  ',
    ' — '
  ],

  '3' => [
    ' — ',
    '  |',
    ' — ',
    '  |',
    ' — '
  ],

  '4'  => [
    '| |',
    '| |',
    ' —|',
    '  |',
    '  |'
  ],

  '5' => [
    ' — ',
    '|  ',
    ' — ',
    '  |',
    ' — '
  ],

  '6' => [
    ' — ',
    '|  ',
    ' — ',
    '| |',
    ' — '
  ],

  '7' => [
    ' — ',
    '  |',
    '  |',
    '  |',
    '  |'
  ],

  '8' => [
    ' — ',
    '| |',
    ' — ',
    '| |',
    ' — '
  ],

  '9' => [
    ' — ',
    '| |',
    ' — ',
    '  |',
    ' — '
  ]
}

############################################

def build_lcd_numbers(input)
  [].tap do |lcd_numbers|
    input.length.times do |index|
      lcd_numbers << NUMBERS[input[index]]
    end
  end
end

def print_lcd_numbers(lcd_numbers, options)
  num_rows    = ROWS
  num_columns = lcd_numbers.size

  num_rows.times do |row|
    options[:size].times do
      num_columns.times do |column|
        lcd_numbers[column][row].chars.each do |segment|
          options[:size].times { putc segment }
        end
        options[:size].times { putc ' ' }
      end
      puts
    end
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
