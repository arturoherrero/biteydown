#!/usr/bin/env ruby

require 'github/markup'

markdown_file = ARGV[0]
output_dir = File.dirname(markdown_file) + '/'
output_filename = File.basename(markdown_file, File.extname(markdown_file))
html_file = "#{output_dir}#{output_filename}.html"

if markdown_file && File.exists?(markdown_file)
  File.open(html_file, 'w') do |f|
    f.write(GitHub::Markup.render(markdown_file))
  end
else
  puts "usage: #{$0} FILE"
end
