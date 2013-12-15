#!/usr/bin/env ruby

# Test Strings
# I had a ((an adjective)) sandwich for lunch today. It dripped all over my ((a body part)) and ((a noun)).
# Our favorite language is ((gem:a gemstone)). We think ((gem)) is better than ((a gemstone)).

print "Give me a madlib! "
mad_lib = gets.chomp

fixed_mad_lib = mad_lib.dup

aliases = []

mad_lib.scan(/\(\(([\w:?\s]+)\)\)/).flatten.each do |match|
  next if aliases.include?(match)
  if match.include?(':')
    match_alias = match.split(':')[0]
    aliases << match_alias
  end

  print "'#{match}'? "
  replacement = gets.chomp

  fixed_mad_lib.gsub!(/\(\(#{match}\)\)/, replacement)
  fixed_mad_lib.gsub!(/\(\(#{match_alias}\)\)/, replacement) unless match_alias.nil?
end

puts
puts fixed_mad_lib