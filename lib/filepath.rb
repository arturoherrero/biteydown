class FilePath
  def initialize(markdown_file)
    @output_dir = File.dirname(markdown_file) + '/'
    @output_filename = File.basename(markdown_file, File.extname(markdown_file))
  end

  def html_path
    "#{output_dir}#{output_filename}.html"
  end

  def pdf_path
    "#{output_dir}#{output_filename}.pdf"
  end

  private

  attr_reader :output_dir, :output_filename
end
