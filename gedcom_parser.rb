#!/usr/bin/env ruby

require 'nokogiri'

class Node
  attr_accessor :type, :id, :value, :nodes

  def initialize(type, id = nil, value = nil)
    @type = type
    @id = id
    @value = value
    @nodes = []
  end
end

unless ARGV.empty?
  nodes = Hash.new { |hash, key| hash[key] = [] }
  # file in
  File.open(ARGV[0]).each_line do |line|
    parts = line.chomp.split
    level = parts[0]
    if parts[1].include?('@')
      id = parts[1]
      type = parts[2].downcase
    else
      type = parts[1].downcase
      value = parts[2..-1].join(' ')
    end
    nodes[level] << Node.new(type, id, value)
  end

  # xml out
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.gedcom {
      nodes.each_key do |key|
        nodes[key].each do |node|
          options = {}
          options[:id] = node.id if node.id
          xml.send(node.type, node.value, options)
        end
      end
    }
  end
  puts builder.to_xml
end