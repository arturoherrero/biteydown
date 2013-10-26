require 'biteydown'

describe Biteydown do
  let(:markdown_path)   { 'example/curriculum.md' }
  let(:html_path)       { 'example/curriculum.html' }
  let(:pdf_path)        { 'example/curriculum.pdf' }
  let(:vendor_css_path) { 'style/style.css' }
  let(:custom_css_path) { 'style/empty.css' }

  it 'create pdf file from a markdown file' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => false,
      :pdf           => true,
    )

    expect(File.exists?(pdf_path)).to be_true
    expect(File.exists?(html_path)).to be_false
  end

  it 'create html file from a markdown file' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => true,
      :pdf           => false,
    )
 
    expect(File.exists?(pdf_path)).to be_false
    expect(File.exists?(html_path)).to be_true
    check_css(html_path, vendor_css_path)
  end


  it 'create html and pdf file from a markdown file' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => true,
      :pdf           => true,
    )

    expect(File.exists?(pdf_path)).to be_true
    expect(File.exists?(html_path)).to be_true
    check_css(html_path, vendor_css_path)
  end

  it 'will include user-supplied CSS' do
    Biteydown.process(
      :markdown_path => markdown_path,
      :html          => true,
      :pdf           => true,
      :css_path      => custom_css_path,
    )

    expect(File.exists?(pdf_path)).to be_true
    expect(File.exists?(html_path)).to be_true
    check_css(html_path, custom_css_path)
  end

  after(:each) do
    File.delete(html_path) if File.exists?(html_path)
    File.delete(pdf_path)  if File.exists?(pdf_path)
  end

  private

  def check_css(html_path, css_path)
    html_content = File.read(html_path)
    css_content = File.read(css_path)
    css_string = "<style>#{css_content}</style>"

    expect(html_content.include?(css_string)).to be_true
  end
end
