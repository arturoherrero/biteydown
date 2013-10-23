require 'filepath'
require 'markup'
require 'converter'

class Biteydown

  def self.process(markdown_path, generate_html, generate_pdf, css_path=nil)
    @markup = Markup.new
    @file_path = FilePath.new(markdown_path)
    @converter = Converter.new(@file_path)

    css_path ||= File.expand_path('../../style/style.css', __FILE__)
    html = @markup.generate_html(markdown_path, css_path)
    @converter.create_pdf_file(html) if generate_pdf
    @converter.create_html_file(html) if generate_html
  end
end
