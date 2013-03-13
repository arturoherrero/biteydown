require 'filepath'
require 'markup'
require 'converter'

class Biteydown

  def self.process(markdown_file, generate_html, generate_pdf)
    @file_path = FilePath.new(markdown_file)
    @markup = Markup.new
    @converter = Converter.new

    html_path = @file_path.get_html_path
    pdf_path = @file_path.get_pdf_path

    html = @markup.generate_html(markdown_file)

    if generate_pdf
      @converter.create_html_file(html, html_path)
      @converter.create_pdf_file(html_path, pdf_path)
      File.delete(html_path)
    end
    if generate_html
      @converter.create_html_file(html, html_path)
    end
  end
end
