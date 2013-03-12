require 'github/markup'

class Biteydown

  def self.process(markdown_file, html, pdf)
    @converter = Converter.new
    @file_path = FilePath.new(markdown_file)

    html_file = @file_path.get_html_file()
    pdf_file = @file_path.get_pdf_file()

    html = @converter.generate_html(markdown_file)

    @converter.create_html_file(html, html_file)
    @converter.create_pdf_file(html_file, pdf_file)
  end
end


class FilePath

  def initialize(markdown_file)
    @output_dir = File.dirname(markdown_file) + '/'
    @output_filename = File.basename(markdown_file, File.extname(markdown_file))
  end

  def get_html_file()
    "#{@output_dir}#{@output_filename}.html"
  end

  def get_pdf_file()
    "#{@output_dir}#{@output_filename}.pdf"
  end
end


class Converter

  def generate_html(markdown_file)
    html = GitHub::Markup.render(markdown_file)
    add_stylesheet!(html)
    add_head!(html)
  end

  def add_head!(html)
    html.insert(0, "\n<head>\n<meta charset='utf-8'>\n</head>\n")
  end

  def add_stylesheet!(html)
    html.insert(0, "\n<style>#{File.read('style/style.css')}</style>\n")
  end

  def create_html_file(html, html_file)
    File.open(html_file, 'w') do |file|
      file.write(html)
    end
  end

  def create_pdf_file(html_file, pdf_file)
    `wkhtmltopdf #{html_file} \
      --encoding UTF-8 \
      --page-size Letter \
      --quiet \
      #{pdf_file}`
  end
end
