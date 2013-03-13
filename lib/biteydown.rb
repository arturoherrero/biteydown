require 'filepath'
require 'markup'
require 'converter'

class Biteydown

  def self.process(markdown_path, generate_html, generate_pdf)
    @markup = Markup.new
    @file_path = FilePath.new(markdown_path)
    @converter = Converter.new(@file_path)

    html = @markup.generate_html(markdown_path)
    @converter.create_pdf_file(html) if generate_pdf
    @converter.create_html_file(html) if generate_html
  end
end
