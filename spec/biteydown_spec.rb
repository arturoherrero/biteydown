require 'biteydown'

describe Biteydown do
  markdown_path = 'example/curriculum.md'
  html_path = 'example/curriculum.html'
  pdf_path = 'example/curriculum.pdf'
  vendor_css = 'style/style.css'
  custom_css = 'style/empty.css'

  it 'create html file from a markdown file' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => true,
      :pdf           => false,
    )
 
    File.exists?(pdf_path).should be_false
    File.exists?(html_path).should be_true
    check_contains(html_path, vendor_css)
  end

  it 'create pdf file from a markdown file' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => false,
      :pdf           => true,
    )

    File.exists?(pdf_path).should be_true
    File.exists?(html_path).should be_false
  end

  it 'create html and pdf file from a markdown file' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => true,
      :pdf           => true,
    )

    File.exists?(pdf_path).should be_true
    File.exists?(html_path).should be_true
    check_contains(html_path, vendor_css)
  end

  it 'will include user-supplied CSS' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => true,
      :pdf           => true,
      :css_path      => custom_css,
    )

    File.exists?(pdf_path).should be_true
    File.exists?(html_path).should be_true
    check_contains(html_path, custom_css)
  end

  after(:each) do
    File.delete(html_path) if File.exists?(html_path)
    File.delete(pdf_path)  if File.exists?(pdf_path)
  end

  private

  def check_contains(html_path, css_path)
    html_content = File.read(html_path)
    css_content = File.read(css_path)
    css_string = "<style>#{css_content}</style>"
    html_content.include?(css_string).should be_true
  end
end
