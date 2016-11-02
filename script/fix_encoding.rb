#!/usr/bin/env ruby

require 'pry'

def fix_encoding(filename)
  print "Fixing #{filename}\n"
  raw_file_stat = `file #{filename}`
  print "File utility reports #{raw_file_stat}\n"
  raw_file_stat.match /(\w+)-endian (\S+)/
  endian=$1
  file_encoding=$2

  raw_contents = File.read(filename, :mode => 'rb', :encoding => 'UTF-16LE')
  internal = raw_contents.encode('UTF-8')
  internal.sub!( 'encoding="UTF-8"', 'encoding="UTF-16"')

  output = internal.encode('UTF-16LE')
  
  File.open(filename, :mode => 'wb', :encoding => 'UTF-16LE') { |f| f.write(output) }

end

if ARGV.count < 1
  file_list = Dir.glob('../document_xml/*.xml')
else
  file_list = ARGV
end

file_list.each do |filename|
  fix_encoding(filename)
end

