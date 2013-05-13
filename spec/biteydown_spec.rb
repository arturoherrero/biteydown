require 'biteydown'

describe Biteydown do

  markdown_path = 'example/curriculum.md'
  html_path = 'example/curriculum.html'
  pdf_path = 'example/curriculum.pdf'

  it 'create html file from a markdown file' do
    Biteydown.process(markdown_path, true, false)
    File.exists?(html_path).should be_true
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
    File.exists?(pdf_path).should be_true
  end

  after(:each) do
    File.delete(html_path) if File.exists?(html_path)
    File.delete(pdf_path) if File.exists?(pdf_path)
  end
end
