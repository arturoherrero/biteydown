require 'biteydown'

describe Biteydown do

  markdown_path = 'example/curriculum.md'
  html_path = 'example/curriculum.html'
  pdf_path = 'example/curriculum.pdf'

  custom_css = 'style/empty.css'
  non_existent_css = 'style/weird_name.css'
  vendor_css = 'style/style.css'


  def check_contains(html_path, css_path)
    html_contents = File.read(html_path)
    css_contents = File.read(css_path)
    css_string = "<style>#{css_contents}</style>"
    html_contents.include?(css_string).should be_true
  end

  it 'create html file from a markdown file' do
    Biteydown.process(markdown_path, true, false)
    File.exists?(html_path).should be_true
    check_contains(html_path, vendor_css)
    File.exists?(pdf_path).should be_false
  end

  it 'create pdf file from a markdown file' do
    Biteydown.process(markdown_path, false, true)
    File.exists?(html_path).should be_false
    File.exists?(pdf_path).should be_true
  end

  it 'create html and pdf file from a markdown file' do
    Biteydown.process(markdown_path, true, true)
    File.exists?(html_path).should be_true
    check_contains(html_path, vendor_css)
    File.exists?(pdf_path).should be_true
  end

  it 'will include user-supplied CSS' do
    Biteydown.process(markdown_path, true, true, custom_css)
    File.exists?(html_path).should be_true
    File.exists?(pdf_path).should be_true
    check_contains(html_path, custom_css)
  end

  it 'does not rescue exceptions on non-existent file' do
    lambda { Biteydown.process(markdown_path, true, true, non_existent_css) }.should raise_error(Errno::ENOENT)
    File.exists?(html_path).should be_false
    File.exists?(pdf_path).should be_false
  end

  after(:each) do
    File.delete(html_path) if File.exists?(html_path)
    File.delete(pdf_path) if File.exists?(pdf_path)
  end
end
