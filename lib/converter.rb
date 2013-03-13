class Converter

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
