#!/usr/bin/env ruby

require 'nokogiri'
require 'pry'

filename = ARGV.first

doc = File.open(filename) { |f| Nokogiri::XML(f) }

p doc.search('title').first.text

