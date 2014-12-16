require_relative 'converter'
require_relative 'filepath'
require_relative 'markup'

class Biteydown
  class << self
    def process(options)
      @options = options

      create_pdf_file  if generate_pdf?
      create_html_file if generate_html?
    end

    private

    attr_reader :options

    def create_pdf_file
      converter.create_pdf_file(raw_html)
    end

    def create_html_file
      converter.create_html_file(raw_html)
    end

    def generate_html?
      options.fetch(:html, false)
    end

    def generate_pdf?
      options.fetch(:pdf, false)
    end

    def markdown_path
      options.fetch(:markdown_path)
    end

    def css_path
      options.fetch(:css_path, File.expand_path('../../style/style.css', __FILE__))
    end

    def raw_html
      markup.generate_html(markdown_path, css_path)
    end

    def markup
      @markup ||= Markup.new
    end

    def converter
      @converter ||= Converter.new(file_path)
    end

    def file_path
      FilePath.new(markdown_path)
    end
  end
end
