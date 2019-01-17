class Converter
  def initialize(file_path)
    @html_path = file_path.html_path
    @pdf_path = file_path.pdf_path
  end

  def create_html_file(html)
    File.open(html_path, 'w') do |file|
      file.write(html)
    end
  end

  def create_pdf_file(html)
    create_html_file(html)

    `wkhtmltopdf \
      --encoding UTF-8 \
      --page-size Letter \
      --quiet \
      #{html_path} \
      #{pdf_path}`

    File.delete(html_path)
  end

  private

  attr_reader :html_path, :pdf_path
end
